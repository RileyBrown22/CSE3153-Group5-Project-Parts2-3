-- Riley | Part 2: create tables from the NER diagram

-- Drop tables (children first) so the script can be re-run
DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS PurchaseItem;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS CustomerEmail;
DROP TABLE IF EXISTS CustomerPhone;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Repair;
DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Offer;

-- Offer: supertype of Product and Service
CREATE TABLE Offer (
    Offer_ID    INT          NOT NULL PRIMARY KEY,
    Description VARCHAR(200) NOT NULL
);

-- Product: subtype of Offer. Offer_ID is PK and FK
CREATE TABLE Product (
    Offer_ID           INT           NOT NULL PRIMARY KEY REFERENCES Offer(Offer_ID),
    Product_Name       VARCHAR(100)  NOT NULL,
    Standard_Price     DECIMAL(10,2) NOT NULL,
    First_Release_Date DATE          NOT NULL
);

-- Service: subtype of Offer. Offer_ID is PK and FK
CREATE TABLE Service (
    Offer_ID          INT          NOT NULL PRIMARY KEY REFERENCES Offer(Offer_ID),
    Unit_Name         VARCHAR(100) NOT NULL,
    Service_Condition VARCHAR(200) NOT NULL
);

-- Repair: subtype of Service. FK to Product
CREATE TABLE Repair (
    Offer_ID         INT           NOT NULL PRIMARY KEY REFERENCES Service(Offer_ID),
    Repair_Cost      DECIMAL(10,2) NOT NULL,
    Product_Offer_ID INT           NOT NULL REFERENCES Product(Offer_ID)
);

-- Maintenance: subtype of Service. Hourly_Rate
CREATE TABLE Maintenance (
    Offer_ID    INT           NOT NULL PRIMARY KEY REFERENCES Service(Offer_ID),
    Hourly_Rate DECIMAL(10,2) NOT NULL
);

-- Customer (Age is computed from Date_of_Birth)
CREATE TABLE Customer (
    Customer_ID   INT          NOT NULL PRIMARY KEY,
    First_Name    VARCHAR(50)  NOT NULL,
    Last_Name     VARCHAR(50)  NOT NULL,
    Date_of_Birth DATE         NOT NULL,
    Age           AS (DATEDIFF(YEAR, Date_of_Birth, GETDATE())
                      - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, Date_of_Birth, GETDATE()), Date_of_Birth) > GETDATE() THEN 1 ELSE 0 END),
    Street        VARCHAR(100) NOT NULL,
    City          VARCHAR(50)  NOT NULL,
    [State]       CHAR(2)      NOT NULL,
    Zip           VARCHAR(10)  NOT NULL
);

-- CustomerPhone: multivalued, composite PK
CREATE TABLE CustomerPhone (
    Customer_ID  INT         NOT NULL REFERENCES Customer(Customer_ID),
    Phone_Number VARCHAR(20) NOT NULL,
    PRIMARY KEY (Customer_ID, Phone_Number)
);

-- CustomerEmail: multivalued, composite PK
CREATE TABLE CustomerEmail (
    Customer_ID   INT          NOT NULL REFERENCES Customer(Customer_ID),
    Email_Address VARCHAR(100) NOT NULL,
    PRIMARY KEY (Customer_ID, Email_Address)
);

-- Purchase: FK to Customer
CREATE TABLE Purchase (
    Purchase_ID    INT          NOT NULL PRIMARY KEY,
    Purchase_Date  DATE         NOT NULL,
    Contact_Person VARCHAR(100) NOT NULL,
    Customer_ID    INT          NOT NULL REFERENCES Customer(Customer_ID)
);

-- PurchaseItem: links Purchase and Offer, composite PK
CREATE TABLE PurchaseItem (
    Purchase_ID INT NOT NULL REFERENCES Purchase(Purchase_ID),
    Offer_ID    INT NOT NULL REFERENCES Offer(Offer_ID),
    PRIMARY KEY (Purchase_ID, Offer_ID)
);

-- Bill: FK to Customer and Service
CREATE TABLE Bill (
    Bill_ID         INT           NOT NULL PRIMARY KEY,
    Date_Of_Service DATE          NOT NULL,
    Bill_Due_Date   DATE          NOT NULL,
    Amount_Due      DECIMAL(10,2) NOT NULL,
    Customer_ID     INT           NOT NULL REFERENCES Customer(Customer_ID),
    Offer_ID        INT           NOT NULL REFERENCES Service(Offer_ID)
);
