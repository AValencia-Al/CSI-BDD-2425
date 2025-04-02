create or alter view Task4B as

SELECT 
    i.IncidentID,
    i.TypeOfIncident,
    i.LocationOfIncident,
    i.DateOfIncident,
    s.Name AS SeniorOfficerName,
    fs.StationName
FROM Incident i
JOIN Emergency_Service_Coordination esc_police ON i.IncidentID = esc_police.IncidentID AND esc_police.ServiceType = 'Police'
JOIN Emergency_Service_Coordination esc_ambulance ON i.IncidentID = esc_ambulance.IncidentID AND esc_ambulance.ServiceType = 'Ambulance'
JOIN SeniorOfficer so ON esc_police.SeniorOfficerID = so.StaffID
JOIN Staff s ON so.StaffID = s.StaffID
JOIN FireStation_Incident fsi ON i.IncidentID = fsi.IncidentID
JOIN FireStation fs ON fsi.FireStationID = fs.StationID
WHERE 
    i.DateOfIncident >= '2023-03-01'
    AND i.DateOfIncident <= '2023-03-31'
    AND i.Police = 1
    AND i.Ambulance = 1
	GROUP BY i.IncidentID, i.TypeOfIncident, i.LocationOfIncident, i.DateOfIncident, s.Name, fs.StationName
	go


select * from Task4B
ORDER BY DateOfIncident DESC;