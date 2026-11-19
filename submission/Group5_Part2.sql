-- CSE 3153 Group 5: Project Part 2 (tables, data, queries). Run top to bottom.

-- ===== 01-create-tables =====
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

-- ===== 02-insert-data =====
-- Riley | Part 2: sample data, 3+ rows per table, parents before children

-- Offer
INSERT INTO Offer (Offer_ID, Description) VALUES
(1,  'ProBook laptop sale'),
(2,  'TowerMax desktop sale'),
(3,  'SwiftPhone smartphone sale'),
(4,  'USB-C dock sale'),
(5,  'Laptop hardware repair'),
(6,  'Desktop hardware repair'),
(7,  'Phone screen repair'),
(8,  'On-site network maintenance'),
(9,  'Monthly server maintenance'),
(10, 'Annual workstation maintenance');

-- Product (two under $500)
INSERT INTO Product (Offer_ID, Product_Name, Standard_Price, First_Release_Date) VALUES
(1, 'ProBook Laptop',    899.99, '2025-03-01'),
(2, 'TowerMax Desktop',  650.00, '2024-11-15'),
(3, 'SwiftPhone',        349.99, '2025-09-20'),
(4, 'USB-C Dock',        129.99, '2024-06-10');

-- Service
INSERT INTO Service (Offer_ID, Unit_Name, Service_Condition) VALUES
(5,  'Hardware Repair Unit', 'In-warranty only'),
(6,  'Hardware Repair Unit', 'Out-of-warranty, parts extra'),
(7,  'Mobile Repair Unit',   'Walk-in, same day'),
(8,  'Field Services',       'On-site visit required'),
(9,  'Server Operations',    'Monthly contract'),
(10, 'Field Services',       'Annual contract');

-- Repair
INSERT INTO Repair (Offer_ID, Repair_Cost, Product_Offer_ID) VALUES
(5, 120.00, 1),
(6, 200.00, 2),
(7,  75.00, 3);

-- Maintenance
INSERT INTO Maintenance (Offer_ID, Hourly_Rate) VALUES
(8,  45.00),
(9,  80.00),
(10, 60.00);

-- Customer
INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Date_of_Birth, Street, City, [State], Zip) VALUES
(1, 'Maria',  'Santos',  '1990-05-12', '100 Main St',  'Kennesaw', 'GA', '30144'),
(2, 'David',  'Nguyen',  '1985-09-23', '200 Oak Ave',  'Marietta', 'GA', '30060'),
(3, 'Priya',  'Patel',   '1998-01-30', '300 Pine Rd',  'Acworth',  'GA', '30101'),
(4, 'Marcus', 'Johnson', '1979-11-02', '400 Cedar Ln', 'Atlanta',  'GA', '30303'),
(5, 'Elena',  'Rossi',   '2001-07-19', '500 Maple Dr', 'Roswell',  'GA', '30075');

-- CustomerPhone
INSERT INTO CustomerPhone (Customer_ID, Phone_Number) VALUES
(1, '770-555-0101'),
(1, '770-555-0111'),
(2, '770-555-0102'),
(3, '770-555-0103'),
(4, '404-555-0104'),
(5, '678-555-0105');

-- CustomerEmail
INSERT INTO CustomerEmail (Customer_ID, Email_Address) VALUES
(1, 'maria.santos@example.com'),
(2, 'david.nguyen@example.com'),
(2, 'dnguyen@work.example.com'),
(3, 'priya.patel@example.com'),
(4, 'marcus.johnson@example.com'),
(5, 'elena.rossi@example.com');

-- Purchase
INSERT INTO Purchase (Purchase_ID, Purchase_Date, Contact_Person, Customer_ID) VALUES
(1, '2026-01-10', 'Maria Santos',   1),
(2, '2026-02-14', 'Tom Nguyen',     2),
(3, '2026-03-02', 'Priya Patel',    3),
(4, '2026-04-18', 'Marcus Johnson', 4),
(5, '2026-05-25', 'Elena Rossi',    5);

-- PurchaseItem
INSERT INTO PurchaseItem (Purchase_ID, Offer_ID) VALUES
(1, 1),
(1, 4),
(2, 2),
(3, 3),
(3, 7),
(4, 9),
(5, 8);

-- Bill (bills 2 and 5 are for services the customer did not purchase)
INSERT INTO Bill (Bill_ID, Date_Of_Service, Bill_Due_Date, Amount_Due, Customer_ID, Offer_ID) VALUES
(1, '2026-01-20', '2026-02-20', 120.00, 1, 5),
(2, '2026-02-01', '2026-03-01', 200.00, 2, 6),
(3, '2026-03-10', '2026-04-10',  75.00, 3, 7),
(4, '2026-04-25', '2026-05-25', 320.00, 4, 9),
(5, '2026-05-30', '2026-06-30', 180.00, 1, 8),
(6, '2026-06-15', '2026-07-15', 600.00, 5, 10);

-- ===== 03-queries =====
-- Part 2: BA queries, run after 01 and 02

-- Query 1 (Douglas): customers and their purchases
SELECT
    Customer.*,
    Purchase.Purchase_ID,
    Purchase.Purchase_Date,
    Purchase.Contact_Person,
    Offer.Offer_ID,
    Offer.Description
FROM Customer
LEFT JOIN Purchase
    ON Customer.Customer_ID = Purchase.Customer_ID
LEFT JOIN PurchaseItem
    ON Purchase.Purchase_ID = PurchaseItem.Purchase_ID
LEFT JOIN Offer
    ON PurchaseItem.Offer_ID = Offer.Offer_ID
ORDER BY Customer.Customer_ID, Purchase.Purchase_ID, Offer.Offer_ID;
-- Query 2 (Douglas): products under $500
SELECT
    Offer.Offer_ID,
    Offer.Description,
    Product.Product_Name,
    Product.Standard_Price,
    Product.First_Release_Date
FROM Product
JOIN Offer
    ON Product.Offer_ID = Offer.Offer_ID
WHERE Product.Standard_Price < 500
ORDER BY Product.Standard_Price, Offer.Offer_ID;
-- Query 3 (Ayman): offerings and their products
SELECT
    Offer.Offer_ID,
    Offer.Description,
    Product.Product_Name,
    Product.Standard_Price,
    Product.First_Release_Date
FROM Offer
JOIN Product
    ON Offer.Offer_ID = Product.Offer_ID;

-- Query 4 (Jacob): customers and number of services received
SELECT
Customer.Customer_ID,
Customer.First_Name,
Customer.Last_Name,
COUNT(Bill.Bill_ID) AS Number_Of_Services
FROM Customer
LEFT JOIN Bill
ON Customer.Customer_ID = Bill.Customer_ID
GROUP BY
Customer.Customer_ID,
Customer.First_Name,
Customer.Last_Name
ORDER BY Customer.Customer_ID;
-- Query 5 (Jacob): most expensive service and its customer
-- "Most expensive" = the highest bill Amount_Due
SELECT TOP 1
Service.Offer_ID,
Service.Unit_Name,
Bill.Amount_Due,
Customer.First_Name,
Customer.Last_Name
FROM Bill
JOIN Service
ON Bill.Offer_ID = Service.Offer_ID
JOIN Customer
ON Bill.Customer_ID = Customer.Customer_ID
ORDER BY Bill.Amount_Due DESC;

-- Query 6 (Ayman): oldest service and its info
SELECT TOP 1
    Bill.Bill_ID,
    Bill.Date_Of_Service,
    Service.Offer_ID,
    Offer.Description,
    Service.Unit_Name,
    Service.Service_Condition
FROM Bill
JOIN Service
    ON Bill.Offer_ID = Service.Offer_ID
JOIN Offer
    ON Service.Offer_ID = Offer.Offer_ID
ORDER BY Bill.Date_Of_Service ASC;

