CREATE PROCEDURE sp_PumpingApplianceIncidentReport
    @TimePeriod VARCHAR(10),        -- 'week', 'month', or 'quarter'
    @StartDate DATE = NULL,         -- Optional start date parameter
    @EndDate DATE = NULL            -- Optional end date parameter
AS
BEGIN
    -- Declare variables for date range
    DECLARE @RangeStart DATE;
    DECLARE @RangeEnd DATE;
    
    -- Set default dates if not provided
    IF @StartDate IS NULL
        SET @StartDate = GETDATE();
        
    IF @EndDate IS NULL
        SET @EndDate = GETDATE();
    
    -- Calculate date range based on time period parameter
    IF @TimePeriod = 'week'
    BEGIN
        SET @RangeStart = DATEADD(WEEK, -1, @StartDate);
        SET @RangeEnd = @EndDate;
    END
    ELSE IF @TimePeriod = 'month'
    BEGIN
        SET @RangeStart = DATEADD(MONTH, -1, @StartDate);
        SET @RangeEnd = @EndDate;
    END
    ELSE IF @TimePeriod = 'quarter'
    BEGIN
        SET @RangeStart = DATEADD(MONTH, -3, @StartDate);
        SET @RangeEnd = @EndDate;
    END
    ELSE -- Default to custom date range
    BEGIN
        SET @RangeStart = @StartDate;
        SET @RangeEnd = @EndDate;
    END
    
    -- Main report query - detailed incidents by pumping appliance
    SELECT 
        a.ApplianceID,
        a.TypeOfAppliance,
        fs.StationName,
        i.IncidentID,
        i.TypeOfIncident,
        i.LocationOfIncident,
        i.DateOfIncident,
        i.CallOutTime,
        i.ArrivalTime,
        i.AllClearTime,
        DATEDIFF(MINUTE, i.CallOutTime, i.ArrivalTime) AS ResponseTimeMinutes,
        CASE WHEN i.FalseCall = 1 THEN 'False Alarm' ELSE 'Genuine Call' END AS CallType,
        CASE WHEN i.Police = 1 OR i.Ambulance = 1 THEN 'Yes' ELSE 'No' END AS EmergencyServicesInvolved
    FROM 
        Appliance a
        JOIN Appliance_Incident ai ON a.ApplianceID = ai.ApplianceID
        JOIN Incident i ON ai.IncidentID = i.IncidentID
        JOIN FireStation_Appliance fsa ON a.ApplianceID = fsa.ApplianceID
        JOIN FireStation fs ON fsa.FireStationID = fs.StationID
    WHERE 
        a.TypeOfAppliance LIKE '%Pumping%'
        AND i.DateOfIncident BETWEEN @RangeStart AND @RangeEnd
    ORDER BY 
        a.ApplianceID,
        i.DateOfIncident;
    
    -- Summary totals by pumping appliance
    SELECT 
        a.ApplianceID,
        a.TypeOfAppliance,
        fs.StationName,
        COUNT(i.IncidentID) AS TotalIncidentsAttended,
        SUM(CASE WHEN i.TrueCall = 1 THEN 1 ELSE 0 END) AS GenuineCallouts,
        SUM(CASE WHEN i.FalseCall = 1 THEN 1 ELSE 0 END) AS FalseAlarms,
        AVG(DATEDIFF(MINUTE, i.CallOutTime, i.ArrivalTime)) AS AvgResponseTimeMinutes
    FROM 
        Appliance a
        JOIN Appliance_Incident ai ON a.ApplianceID = ai.ApplianceID
        JOIN Incident i ON ai.IncidentID = i.IncidentID
        JOIN FireStation_Appliance fsa ON a.ApplianceID = fsa.ApplianceID
        JOIN FireStation fs ON fsa.FireStationID = fs.StationID
    WHERE 
        a.TypeOfAppliance LIKE '%Pumping%'
        AND i.DateOfIncident BETWEEN @RangeStart AND @RangeEnd
    GROUP BY 
        a.ApplianceID,
        a.TypeOfAppliance,
        fs.StationName
    ORDER BY 
        COUNT(i.IncidentID) DESC;
END;
GO

