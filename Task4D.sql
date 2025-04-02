CREATE PROCEDURE sp_MonthlyAverageCallouts
AS
BEGIN
    -- Set NOCOUNT ON to prevent extra result sets that can interfere with result processing
    SET NOCOUNT ON;

    -- Main query to get monthly average callouts by station
    SELECT 
        fs.StationID,
        fs.StationName,
        MONTH(i.DateOfIncident) AS Month,
        YEAR(i.DateOfIncident) AS Year,
        -- Count of firefighters at the station
        COUNT(DISTINCT f.StaffID) AS FirefighterCount,
        -- Count of incidents the station responded to in the month
        COUNT(DISTINCT fsi.IncidentID) AS IncidentCount,
        -- Average callouts per firefighter (using CAST to ensure decimal division)
        CAST(COUNT(DISTINCT fsi.IncidentID) AS FLOAT) / 
            CASE WHEN COUNT(DISTINCT f.StaffID) = 0 THEN 1 
                 ELSE COUNT(DISTINCT f.StaffID) END AS AverageCalloutsPerFirefighter
    FROM 
        FireStation fs
        -- Get all firefighters assigned to the station
        LEFT JOIN Staff s ON fs.StationID = s.StationID
        LEFT JOIN Firefighter f ON s.StaffID = f.StaffID
        -- Get all incidents the station responded to
        LEFT JOIN FireStation_Incident fsi ON fs.StationID = fsi.FireStationID
        LEFT JOIN Incident i ON fsi.IncidentID = i.IncidentID
    WHERE 
        -- Only include genuine callouts (not false alarms)
        (i.TrueCall = 1 OR i.TrueCall IS NULL)
    -- Group by station, month, and year
    GROUP BY 
        fs.StationID,
        fs.StationName,
        MONTH(i.DateOfIncident),
        YEAR(i.DateOfIncident)
    -- Order by station, year, month
    ORDER BY 
        fs.StationName,
        YEAR(i.DateOfIncident),
        MONTH(i.DateOfIncident);
END;
GO
