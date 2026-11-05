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
