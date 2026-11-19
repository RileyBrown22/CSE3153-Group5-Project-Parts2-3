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
    Offer_ID,
    Product_Name,
    Standard_Price,
    First_Release_Date
FROM Product
WHERE Standard_Price < 500
ORDER BY Standard_Price, Offer_ID;
-- Query 3 (Ayman): offerings and their products

-- Query 4 (Jacob): customers and number of services received

-- Query 5 (Jacob): most expensive service and its customer

-- Query 6 (Ayman): oldest service and its info
