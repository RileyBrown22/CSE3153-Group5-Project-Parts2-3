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
