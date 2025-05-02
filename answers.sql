-- Achieving 1NF
USE company_db;

SELECT OrderID, CustomerName, Product
FROM ProductDetail
CROSS JOIN UNNEST(string_to_array(Products, ',')) AS Product;
-- This query selects the OrderID, CustomerName, and each individual Product from the ProductDetail table.
-- Achieving 2NF
USE company_db;
-- Table 1: OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert data into OrderDetails table
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Table 2: CustomerDetails
CREATE TABLE CustomerDetails (
    OrderID INT,
    CustomerName VARCHAR(255),
    PRIMARY KEY (OrderID)
);

-- Insert data into CustomerDetails table
INSERT INTO CustomerDetails (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;
-- Test change
