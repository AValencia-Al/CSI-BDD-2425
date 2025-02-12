CREATE TABLE CUSTOMER(
CustomerID   int  NOT NULL,
LastName     varchar(25)  NOT NULL,
FirstName    varchar(25)  NOT NULL,
EmailAddress varchar(30)  NULL,
EncryptedPassword varchar(16) NULL,  
Addresss varchar(255) NULL,
City varchar(255) NULL, 
Statee varchar(255) NULL,
Zip varchar(10) NULL,
Phone varchar(20) NOT NULL,
CONSTRAINT CustomerPK PRIMARY KEY(CustomerID),
CONSTRAINT EmailAK1	  UNIQUE(EmailAddress)
);

CREATE TABLE EMPLOYEE(
EmployeeID int NOT NULL,
LastName varchar(255) NOT NULL,
FirstName varchar(255) NOT NULL,
Phone varchar(20) NOT NULL,
Email varchar(30) NOT NULL,
CONSTRAINT EmployeePK PRIMARY KEY(EmployeeID),
CONSTRAINT EmailAK2 UNIQUE(Email)
);

CREATE TABLE VENDOR(
VendorID   int  NOT NULL,
CompanyName     varchar(25)  NULL,
ContactLastName    varchar(25)  NOT NULL,
ContactFirstName   varchar(25) NOT NULL,
Addresss varchar(255) NULL,
City varchar(255) NULL, 
Statee varchar(255) NULL,
Zip varchar(10) NULL,
Phone varchar(20) NOT NULL,
Fax int NULL,
Email1 varchar(30) NULL,
CONSTRAINT VendorPK PRIMARY KEY(VendorID),
CONSTRAINT EmailAK3	  UNIQUE(Email1)
);

CREATE TABLE ITEM(
ItemID   int  NOT NULL,
ItemDescription     varchar(25) NOT NULL,
PurchaseDate    Date  NOT NULL,
ItemCost   int NOT NULL,
ItemPrice real NOT NULL,
VendorID int  NOT NULL, 
CONSTRAINT ItemPK PRIMARY KEY(ItemID),
CONSTRAINT VendorFK	  FOREIGN KEY(VendorID)
);

CREATE TABLE SALE(
SaleID int NOT NULL,
CustomerID int NOT NULL,
EmployeeID int NOT NULL,
SaleDate date NOT NULL, 
SubTotal real NULL,
Tax real NULL,
Total real NULL,
CONSTRAINT SalePK PRIMARY KEY(SaleID),
CONSTRAINT CustomerFK FOREIGN KEY(CustomerID),
CONSTRAINT EmployeeFK FOREIGN KEY(SELECT EmployeeID)
);


