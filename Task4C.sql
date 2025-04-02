create or alter view Task4C as
SELECT 
        s.StaffID,
        s.Name,
        s.PhoneNumber,
        f.Safety_Cert_Number,
        fs.StationName
    FROM Staff s
    JOIN Firefighter f ON s.StaffID = f.StaffID
    JOIN FireStation fs ON s.StationID = fs.StationID
    WHERE s.StaffID NOT IN (
        SELECT DISTINCT si.StaffID
        FROM Staff_Incident si
        WHERE GETDATE() BETWEEN si.StartTime AND si.EndTime
    )
  
  select * from Task4C
   ORDER BY StationName, Name;