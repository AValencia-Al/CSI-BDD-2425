
-- Create FireStation table
CREATE TABLE FireStation (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    Station_phone_no VARCHAR(20) NOT NULL,
    area_command_no VARCHAR(20) NOT NULL,
    AreaCommandNumber VARCHAR(20) NOT NULL,
    StaffTotal INT NOT NULL,
    AreaID INT NOT NULL,
    FOREIGN KEY (AreaID) REFERENCES AreaCommand(AreaID)
);

-- Create Staff table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    HomeAddress VARCHAR(200) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    AllocatedFireStation INT,
    FireStationID INT NOT NULL,
    StationID INT NOT NULL,
    PersonnelNumber VARCHAR(20) NOT NULL,
    AdminStaffID VARCHAR(20),
    FOREIGN KEY (StationID) REFERENCES FireStation(StationID)
);

-- Create Firefighter table
CREATE TABLE Firefighter (
    StaffID INT PRIMARY KEY,
    Safety_Cert_Number INTEGER NOT NULL,
    CertRenewalDate DATE NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Create AdminStaff table
CREATE TABLE AdminStaff (
    StaffID INT PRIMARY KEY,
    JobDescription VARCHAR(200) NOT NULL,
    Grade VARCHAR(20) NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Create SeniorOfficer table
CREATE TABLE SeniorOfficer (
    StaffID INT PRIMARY KEY,
    AreaCommandNumber VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    MobileNumber VARCHAR(20) NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Create Appliance table
CREATE TABLE Appliance (
    ApplianceID INT PRIMARY KEY,
    TypeOfAppliance VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FireStationID INT NOT NULL,
    FOREIGN KEY (FireStationID) REFERENCES FireStation(StationID)
);

-- Create Appliance_Equipment table
CREATE TABLE Appliance_Equipment (
    ApplianceID INT NOT NULL,
    ApplianceEquipmentID VARCHAR(50) NOT NULL,
    PRIMARY KEY (ApplianceID, ApplianceEquipmentID),
    FOREIGN KEY (ApplianceID) REFERENCES Appliance(ApplianceID)
);

-- Create FireStation_Appliance table
CREATE TABLE FireStation_Appliance (
    FireStationID INT NOT NULL,
    ApplianceID INT NOT NULL,
    PRIMARY KEY (FireStationID, ApplianceID),
    FOREIGN KEY (FireStationID) REFERENCES FireStation(StationID),
    FOREIGN KEY (ApplianceID) REFERENCES Appliance(ApplianceID)
);

-- Create Caller table
CREATE TABLE Caller (
    CallerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

-- Create Incident table
CREATE TABLE Incident (
    IncidentID INT PRIMARY KEY,
    TypeOfIncident VARCHAR(50) NOT NULL,
    LocationOfIncident VARCHAR(200) NOT NULL,
    CallOutTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    AllClearTime DATETIME NOT NULL,
    DateOfIncident DATE NOT NULL,
    FalseCall BIT NOT NULL,
    TrueCall BIT NOT NULL,
    Rescue BIT NOT NULL,
    Police BIT NOT NULL,
    Ambulance BIT NOT NULL,
    CoastGuardSupport BIT NOT NULL
);

-- Create Shift_Incident table
CREATE TABLE Shift_Incident (
    ShiftID INT PRIMARY KEY,
    IncidentID INT NOT NULL,
    Time DATETIME NOT NULL,
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
);

-- Create FireStation_Incident table
CREATE TABLE FireStation_Incident (
    FireStationID INT NOT NULL,
    IncidentID INT NOT NULL,
    PRIMARY KEY (FireStationID, IncidentID),
    FOREIGN KEY (FireStationID) REFERENCES FireStation(StationID),
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
);

-- Create Casualty table
CREATE TABLE Casualty (
    CasualtyID INT PRIMARY KEY,
    IncidentID INT NOT NULL,
    DOB DATE NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    IncidentDate VARCHAR(50) NOT NULL,
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
);

-- Create Fatal_Casualty table
CREATE TABLE Fatal_Casualty (
    CasualtyID INT PRIMARY KEY,
    IncidentID INT NOT NULL,
    CauseOfDeath VARCHAR(100) NOT NULL,
    TimeOfDeath DATETIME NOT NULL,
    IncidentID2 VARCHAR(50) NOT NULL,
    FOREIGN KEY (CasualtyID) REFERENCES Casualty(CasualtyID),
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
);

-- Create Emergency_Service_Coordination table
CREATE TABLE Emergency_Service_Coordination (
    CoordinationID INT PRIMARY KEY,
    IncidentID INT NOT NULL,
    SeniorOfficerID INT NOT NULL,
    ServiceType VARCHAR(50) NOT NULL,
    CoordinationTime TIME NOT NULL,
    CoordinationDate DATE NOT NULL,
    MobileNumberSO VARCHAR(20) NOT NULL,
    SeniorOfficerStaffID VARCHAR(50) NOT NULL,
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID),
    FOREIGN KEY (SeniorOfficerID) REFERENCES SeniorOfficer(StaffID)
);

-- Create Appliance_Incident table
CREATE TABLE Appliance_Incident (
    ApplianceID INT NOT NULL,
    IncidentID INT NOT NULL,
    PRIMARY KEY (ApplianceID, IncidentID),
    FOREIGN KEY (ApplianceID) REFERENCES Appliance(ApplianceID),
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
);

-- Insert test data into AreaCommand
INSERT INTO AreaCommand (AreaID, AreaName, AssistantChiefFireOfficerID, AssistantChiefFireOfficerName, AssistantChiefFireOfficerNumber, RemainOnDuty, ShiftChangeTime)
VALUES 
(1, 'North London', 101, 'James Wilson', 'ACFO001', '08:00:00', '20:00:00'),
(2, 'South London', 102, 'Sarah Johnson', 'ACFO002', '08:00:00', '20:00:00'),
(3, 'East London', 103, 'David Thompson', 'ACFO003', '08:00:00', '20:00:00'),
(4, 'West London', 104, 'Emily Richards', 'ACFO004', '08:00:00', '20:00:00'),
(5, 'Central London', 105, 'Michael Brown', 'ACFO005', '08:00:00', '20:00:00');

-- Insert test data into FireStation
INSERT INTO FireStation (StationID, StationName, Address, Station_phone_no, area_command_no, AreaCommandNumber, StaffTotal, AreaID)
VALUES 
(1, 'Islington Fire Station', '164 Upper Street, Islington, London N1 1TX', '02078336299', 'NC001', 'ACN001', 45, 1),
(2, 'Brixton Fire Station', '84 Gresham Road, Brixton, London SW9 7NP', '02078361884', 'SC001', 'ACN002', 52, 2),
(3, 'Stratford Fire Station', '117 Romford Road, Stratford, London E15 4JA', '02085553333', 'EC001', 'ACN003', 48, 3),
(4, 'Hammersmith Fire Station', '190-192 Shepherd Bush Road, London W6 7NL', '02087482222', 'WC001', 'ACN004', 43, 4),
(5, 'Soho Fire Station', '126 Shaftesbury Avenue, London W1D 5ET', '02077341881', 'CEN001', 'ACN005', 55, 5);

-- Insert test data into Staff
INSERT INTO Staff (StaffID, Name, HomeAddress, PhoneNumber, Role, AllocatedFireStation, FireStationID, StationID, PersonnelNumber, AdminStaffID)
VALUES 
(1, 'John Smith', '21 Oak Road, London N4 2HG', '07700900123', 'Senior Officer', 1, 1, 1, 'P001', NULL),
(2, 'Emma White', '45 Maple Avenue, London SW11 3BN', '07700900124', 'Firefighter', 1, 1, 1, 'P002', NULL),
(3, 'Mark Johnson', '8 Pine Street, London E14 7DL', '07700900125', 'Firefighter', 2, 2, 2, 'P003', NULL),
(4, 'Lisa Brown', '33 Cedar Lane, London W12 8QP', '07700900126', 'Admin Staff', 2, 2, 2, 'P004', 'A001'),
(5, 'Robert Davis', '17 Ash Grove, London SE15 6TY', '07700900127', 'Senior Officer', 3, 3, 3, 'P005', NULL),
(6, 'Susan Wilson', '29 Elm Court, London EC1V 8DS', '07700900128', 'Firefighter', 3, 3, 3, 'P006', NULL),
(7, 'James Taylor', '55 Birch Road, London NW10 3PQ', '07700900129', 'Admin Staff', 4, 4, 4, 'P007', 'A002'),
(8, 'Karen Miller', '12 Willow Close, London SW20 9HF', '07700900130', 'Firefighter', 4, 4, 4, 'P008', NULL),
(9, 'Thomas Hall', '41 Sycamore Drive, London E17 6RT', '07700900131', 'Senior Officer', 5, 5, 5, 'P009', NULL),
(10, 'Helen Turner', '25 Beech Avenue, London SE1 7YU', '07700900132', 'Firefighter', 5, 5, 5, 'P010', NULL),
(11, 'Andrew Clark', '6 Maple Road, London N1 3GR', '07700900133', 'Firefighter', 1, 1, 1, 'P011', NULL),
(12, 'Patricia Lewis', '19 Oak Avenue, London SW4 8HJ', '07700900134', 'Admin Staff', 1, 1, 1, 'P012', 'A003'),
(13, 'Daniel Walker', '37 Pine Close, London E3 5KL', '07700900135', 'Firefighter', 2, 2, 2, 'P013', NULL),
(14, 'Barbara Moore', '22 Cedar Street, London W2 1NB', '07700900136', 'Firefighter', 2, 2, 2, 'P014', NULL),
(15, 'Richard Harris', '14 Ash Lane, London SE12 9DF', '07700900137', 'Senior Officer', 3, 3, 3, 'P015', NULL),
(16, 'Jennifer Adams', '31 Elm Road, London EC2A 4RT', '07700900138', 'Firefighter', 3, 3, 3, 'P016', NULL),
(17, 'Michael Scott', '49 Birch Avenue, London NW3 2QS', '07700900139', 'Admin Staff', 4, 4, 4, 'P017', 'A004'),
(18, 'Elizabeth King', '10 Willow Road, London SW16 5JK', '07700900140', 'Firefighter', 4, 4, 4, 'P018', NULL),
(19, 'Christopher Baker', '27 Sycamore Lane, London E10 6BN', '07700900141', 'Firefighter', 5, 5, 5, 'P019', NULL),
(20, 'Sarah Young', '3 Beech Street, London SE5 8DP', '07700900142', 'Admin Staff', 5, 5, 5, 'P020', 'A005');

-- Insert test data into Firefighter
INSERT INTO Firefighter (StaffID, Safety_Cert_Number, CertRenewalDate)
VALUES 
(2, 12345, '2024-05-15'),
(3, 12346, '2024-06-22'),
(6, 12347, '2024-07-10'),
(8, 12348, '2024-04-30'),
(10, 12349, '2024-08-05'),
(11, 12350, '2024-09-18'),
(13, 12351, '2024-03-25'),
(14, 12352, '2024-07-12'),
(16, 12353, '2024-06-08'),
(18, 12354, '2024-05-29'),
(19, 12355, '2024-04-15');

-- Insert test data into AdminStaff
INSERT INTO AdminStaff (StaffID, JobDescription, Grade)
VALUES 
(4, 'Control Room Operator', 'Grade 3'),
(7, 'Administrative Assistant', 'Grade 2'),
(12, 'Resource Coordinator', 'Grade 4'),
(17, 'Communications Officer', 'Grade 3'),
(20, 'Records Manager', 'Grade 3');

-- Insert test data into SeniorOfficer
INSERT INTO SeniorOfficer (StaffID, AreaCommandNumber, ContactNumber, MobileNumber)
VALUES 
(1, 'ACN001', '02078361111', '07700900223'),
(5, 'ACN003', '02085553334', '07700900227'),
(9, 'ACN005', '02077341882', '07700900231'),
(15, 'ACN003', '02085553335', '07700900237');

-- Insert test data into Appliance
INSERT INTO Appliance (ApplianceID, TypeOfAppliance, Status, FireStationID)
VALUES 
(1, 'Pumping Appliance', 'Active', 1),
(2, 'Aerial Ladder Platform', 'Active', 1),
(3, 'Command Unit', 'Active', 2),
(4, 'Fire Rescue Unit', 'Active', 2),
(5, 'Pumping Appliance', 'Active', 3),
(6, 'Incident Response Unit', 'Active', 3),
(7, 'Pumping Appliance', 'Maintenance', 4),
(8, 'Bulk Foam Unit', 'Active', 4),
(9, 'Pumping Appliance', 'Active', 5),
(10, 'Hose Layer Unit', 'Active', 5),
(11, 'Pumping Appliance', 'Active', 1),
(12, 'Pumping Appliance', 'Active', 2),
(13, 'Pumping Appliance', 'Active', 3),
(14, 'Pumping Appliance', 'Active', 4),
(15, 'Pumping Appliance', 'Active', 5),
(16, 'Turntable Ladder', 'Maintenance', 1),
(17, 'Damage Control Unit', 'Active', 2),
(18, 'Breathing Apparatus Unit', 'Active', 3),
(19, 'Rescue Tender', 'Active', 4),
(20, 'Urban Search and Rescue', 'Active', 5);

-- Insert test data into Appliance_Equipment
INSERT INTO Appliance_Equipment (ApplianceID, ApplianceEquipmentID)
VALUES 
(1, 'Hose-001'),
(1, 'Extinguisher-001'),
(2, 'Ladder-001'),
(3, 'CommsSystem-001'),
(4, 'CuttingTools-001'),
(5, 'Hose-002'),
(6, 'HazmatKit-001'),
(7, 'Hose-003'),
(8, 'FoamSystem-001'),
(9, 'Hose-004'),
(10, 'HoseReel-001'),
(11, 'Extinguisher-002'),
(12, 'Hose-005'),
(13, 'BreathingApp-001'),
(14, 'FirstAid-001'),
(15, 'Extinguisher-003'),
(16, 'LadderExt-001'),
(17, 'SupportKit-001'),
(18, 'OxygenTank-001'),
(19, 'RescueKit-001');

-- Insert test data into FireStation_Appliance
INSERT INTO FireStation_Appliance (FireStationID, ApplianceID)
VALUES 
(1, 1), (1, 2), (1, 11), (1, 16),
(2, 3), (2, 4), (2, 12), (2, 17),
(3, 5), (3, 6), (3, 13), (3, 18),
(4, 7), (4, 8), (4, 14), (4, 19),
(5, 9), (5, 10), (5, 15), (5, 20);

-- Insert test data into Caller
INSERT INTO Caller (CallerID, Name, PhoneNumber, Address)
VALUES 
(1, 'George Thompson', '07123456789', '12 High Street, London N1 5TY'),
(2, 'Mary Williams', '07234567890', '24 Station Road, London SW2 3AB'),
(3, 'Peter Jackson', '07345678901', '8 Church Lane, London E2 6CD'),
(4, 'Jane Roberts', '07456789012', '16 River Way, London W3 7EF'),
(5, 'David Hughes', '07567890123', '32 Park Avenue, London SE4 8GH'),
(6, 'Catherine Evans', '07678901234', '5 Queen Street, London EC1 9IJ'),
(7, 'Steven Morris', '07789012345', '21 King Road, London NW5 0KL'),
(8, 'Michelle Price', '07890123456', '13 Victoria Drive, London SW6 1MN'),
(9, 'Kevin Edwards', '07901234567', '29 Castle Lane, London E7 2OP'),
(10, 'Laura Jones', '07012345678', '3 Albert Court, London W8 3QR'),
(11, 'Brian Davis', '07123123123', '18 Oxford Street, London N9 4ST'),
(12, 'Rebecca Taylor', '07234234234', '42 Cambridge Road, London SW10 5UV'),
(13, 'Anthony Carter', '07345345345', '7 Edinburgh Avenue, London E11 6WX'),
(14, 'Rachel Green', '07456456456', '15 London Road, London W12 7YZ'),
(15, 'Edward Wilson', '07567567567', '31 Bristol Street, London SE13 8AB'),
(16, 'Patricia Smith', '07678678678', '4 Manchester Way, London EC14 9CD'),
(17, 'Richard Johnson', '07789789789', '22 Liverpool Lane, London NW15 0EF'),
(18, 'Donna Lewis', '07890890890', '10 Glasgow Drive, London SW16 1GH'),
(19, 'Timothy Brown', '07901901901', '26 Birmingham Road, London E17 2IJ'),
(20, 'Amanda Walker', '07012012012', '2 Sheffield Court, London W18 3KL');

-- Insert test data into Incident (with emergency service coordination)
INSERT INTO Incident (IncidentID, TypeOfIncident, LocationOfIncident, CallOutTime, ArrivalTime, AllClearTime, DateOfIncident, FalseCall, TrueCall, Rescue, Police, Ambulance, CoastGuardSupport)
VALUES 
(1, 'Fire', '15 Oak Street, London N1 3AB', '2023-03-01 08:15:00', '2023-03-01 08:28:00', '2023-03-01 10:45:00', '2023-03-01', 0, 1, 0, 1, 1, 0),
(2, 'Rescue', '27 Maple Avenue, London SW2 5CD', '2023-03-02 14:30:00', '2023-03-02 14:42:00', '2023-03-02 16:15:00', '2023-03-02', 0, 1, 1, 1, 1, 0),
(3, 'False Alarm', '8 Pine Road, London E3 7EF', '2023-03-03 10:20:00', '2023-03-03 10:35:00', '2023-03-03 11:00:00', '2023-03-03', 1, 0, 0, 0, 0, 0),
(4, 'Fire', '33 Cedar Lane, London W4 9GH', '2023-03-04 18:45:00', '2023-03-04 19:00:00', '2023-03-04 21:30:00', '2023-03-04', 0, 1, 0, 1, 0, 0),
(5, 'Rescue', '12 Ash Court, London SE5 1IJ', '2023-03-05 07:10:00', '2023-03-05 07:25:00', '2023-03-05 09:00:00', '2023-03-05', 0, 1, 1, 1, 1, 0),
(6, 'Fire', '45 Elm Street, London EC6 3KL', '2023-03-06 12:35:00', '2023-03-06 12:50:00', '2023-03-06 14:20:00', '2023-03-06', 0, 1, 0, 0, 0, 0),
(7, 'False Alarm', '19 Birch Road, London NW7 5MN', '2023-03-07 16:15:00', '2023-03-07 16:30:00', '2023-03-07 17:00:00', '2023-03-07', 1, 0, 0, 0, 0, 0),
(8, 'Fire', '22 Willow Drive, London SW8 7OP', '2023-03-08 21:00:00', '2023-03-08 21:12:00', '2023-03-08 23:45:00', '2023-03-08', 0, 1, 0, 1, 1, 0),
(9, 'Hazardous Materials', '37 Sycamore Lane, London E9 9QR', '2023-03-09 09:45:00', '2023-03-09 10:00:00', '2023-03-09 12:30:00', '2023-03-09', 0, 1, 0, 1, 0, 0),
(10, 'Rescue', '5 Beech Avenue, London W10 1ST', '2023-03-10 15:20:00', '2023-03-10 15:35:00', '2023-03-10 17:15:00', '2023-03-10', 0, 1, 1, 1, 1, 1),
(11, 'Fire', '28 Hazelnut Court, London N11 3UV', '2023-03-11 11:50:00', '2023-03-11 12:05:00', '2023-03-11 14:30:00', '2023-03-11', 0, 1, 0, 0, 1, 0),
(12, 'False Alarm', '14 Chestnut Road, London SW12 5WX', '2023-03-12 03:25:00', '2023-03-12 03:40:00', '2023-03-12 04:15:00', '2023-03-12', 1, 0, 0, 0, 0, 0),
(13, 'Fire', '41 Walnut Lane, London E13 7YZ', '2023-03-13 19:10:00', '2023-03-13 19:25:00', '2023-03-13 21:45:00', '2023-03-13', 0, 1, 0, 1, 1, 0),
(14, 'Rescue', '9 Hickory Drive, London W14 9AB', '2023-03-14 13:40:00', '2023-03-14 13:55:00', '2023-03-14 15:30:00', '2023-03-14', 0, 1, 1, 1, 1, 0),
(15, 'False Alarm', '32 Almond Street, London SE15 1CD', '2023-03-15 06:15:00', '2023-03-15 06:30:00', '2023-03-15 07:00:00', '2023-03-15', 1, 0, 0, 0, 0, 0),
(16, 'Fire', '17 Pecan Road, London EC16 3EF', '2023-03-16 22:30:00', '2023-03-16 22:45:00', '2023-03-17 01:15:00', '2023-03-16', 0, 1, 0, 1, 0, 0),
(17, 'Hazardous Materials', '24 Spruce Avenue, London NW17 5GH', '2023-03-17 05:50:00', '2023-03-17 06:05:00', '2023-03-17 08:30:00', '2023-03-17', 0, 1, 0, 1, 0, 0),
(18, 'Rescue', '36 Fir Lane, London SW18 7IJ', '2023-03-18 17:25:00', '2023-03-18 17:40:00', '2023-03-18 19:15:00', '2023-03-18', 0, 1, 1, 1, 1, 0),
(19, 'Fire', '7 Hemlock Court, London E19 9KL', '2023-03-19 14:55:00', '2023-03-19 15:10:00', '2023-03-19 17:45:00', '2023-03-19', 0, 1, 0, 0, 1, 0),
(20, 'False Alarm', '29 Cedar Drive, London W20 1MN', '2023-03-20 01:20:00', '2023-03-20 01:35:00', '2023-03-20 02:00:00', '2023-03-20', 1, 0, 0, 0, 0, 0);

-- Insert test data into Shift_Incident
INSERT INTO Shift_Incident (ShiftID, IncidentID, Time)
VALUES 
(1, 1, '2023-03-01 08:15:00'),
(2, 2, '2023-03-02 14:30:00'),
(3, 3, '2023-03-03 10:20:00'),
(4, 4, '2023-03-04 18:45:00'),
(5, 5, '2023-03-05 07:10:00'),
(6, 6, '2023-03-06 12:35:00'),
(7, 7, '2023-03-07 16:15:00'),
(8, 8, '2023-03-08 21:00:00'),
(9, 9, '2023-03-09 09:45:00'),
(10, 10, '2023-03-10 15:20:00'),
(11, 11, '2023-03-11 11:50:00'),
(12, 12, '2023-03-12 03:25:00'),
(13, 13, '2023-03-13 19:10:00'),
(14, 14, '2023-03-14 13:40:00'),
(15, 15, '2023-03-15 06:15:00'),
(16, 16, '2023-03-16 22:30:00'),
(17, 17, '2023-03-17 05:50:00'),
(18, 18, '2023-03-18 17:25:00'),
(19, 19, '2023-03-19 14:55:00'),
(20, 20, '2023-03-20 01:20:00');

-- Insert test data into FireStation_Incident
INSERT INTO FireStation_Incident (FireStationID, IncidentID)
VALUES 
(1, 1), (1, 6), (1, 11), (1, 16),
(2, 2), (2, 7), (2, 12), (2, 17),
(3, 3), (3, 8), (3, 13), (3, 18),
(4, 4), (4, 9), (4, 14), (4, 19),
(5, 5), (5, 10), (5, 15), (5, 20);

-- Insert test data into Casualty
INSERT INTO Casualty (CasualtyID, IncidentID, DOB, Gender, IncidentDate)
VALUES 
(1, 1, '1985-06-12', 'Male', '2023-03-01'),
(2, 2, '1992-08-24', 'Female', '2023-03-02'),
(3, 4, '1978-03-17', 'Male', '2023-03-04'),
(4, 5, '2001-11-05', 'Male', '2023-04-07')