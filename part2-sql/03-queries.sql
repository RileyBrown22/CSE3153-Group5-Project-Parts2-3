-- Part 2: BA queries, run after 01 and 02

-- Query 1 (Douglas): customers and their purchases

-- Query 2 (Douglas): products under $500

-- Query 3 (Ayman): offerings and their products

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
