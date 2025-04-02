CREATE OR ALTER VIEW Task4A AS
SELECT TOP 1
    fs.StationID,
    fs.StationName,
    COUNT(i.IncidentID) AS GenuineCalloutCount
FROM FireStation fs
JOIN FireStation_Incident fsi ON fs.StationID = fsi.FireStationID
JOIN Incident i ON fsi.IncidentID = i.IncidentID
WHERE 
    i.TrueCall = 1 
    AND i.FalseCall = 0
    AND i.DateOfIncident >= '2023-03-01'
    AND i.DateOfIncident <= '2023-03-31'
GROUP BY fs.StationID, fs.StationName
ORDER BY GenuineCalloutCount DESC;

