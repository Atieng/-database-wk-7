-- Question 1

-- Create a normalized table structure
CREATE TABLE NormalizedOrders AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM ProductDetail
JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL 
    SELECT 4 UNION ALL SELECT 5 -- Add more numbers if needed for more products
) numbers
ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n - 1
ORDER BY OrderID, Product;

-- Question 2

-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails
ORDER BY OrderID;

-- Step 2: Create OrderItems table (contains only full dependencies)
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails
ORDER BY OrderID, Product;

 
-- Verify the normalized structure
SELECT 'Orders Table:' AS TableName;
SELECT * FROM Orders;

SELECT 'OrderItems Table:' AS TableName;
SELECT * FROM OrderItems;