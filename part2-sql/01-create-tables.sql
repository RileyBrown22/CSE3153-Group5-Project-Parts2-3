-- Riley | Part 2: create tables from the NER diagram

-- Drop tables (children first) so the script can be re-run

-- Offer: supertype of Product and Service

-- Product: subtype of Offer. Offer_ID is PK and FK

-- Service: subtype of Offer. Offer_ID is PK and FK

-- Repair: subtype of Service. FK to Product

-- Maintenance: subtype of Service. Hourly_Rate

-- Customer (include age)

-- CustomerPhone: multivalued, composite PK

-- CustomerEmail: multivalued, composite PK

-- Purchase: FK to Customer

-- PurchaseItem: links Purchase and Offer, composite PK

-- Bill: FK to Customer and Service
