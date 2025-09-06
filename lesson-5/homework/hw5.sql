-- Lesson 5: Aliases, Unions, and Conditional Columns (Solutions)
-- SQL Server

-------------------------------------------------
-- Easy-Level Tasks
-------------------------------------------------

-- 1. Alias for column
SELECT ProductName AS Name
FROM Products;

-- 2. Alias for table
SELECT *
FROM Customers AS Client;

-- 3. UNION (Products vs Products_Discounted)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. INTERSECT
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 5. DISTINCT Customers
SELECT DISTINCT FirstName + ' ' + LastName AS CustomerName, Country
FROM Customers;

-- 6. CASE (Price High/Low)
SELECT ProductName,
       Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

-- 7. IIF (StockQuantity > 100)
SELECT ProductName,
       StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStockOver100
FROM Products_Discounted;

-------------------------------------------------
-- Medium-Level Tasks
-------------------------------------------------

-- 8. UNION (again, explicit version)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 9. EXCEPT
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

-- 10. IIF (Expensive / Affordable)
SELECT ProductName,
       Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

-- 11. Employees (Age < 25 OR Salary > 60000)
SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000;

-- 12. Update Salary (HR + EmployeeID = 5)
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentName = 'HR' OR EmployeeID = 5;

-------------------------------------------------
-- Hard-Level Tasks
-------------------------------------------------

-- 13. CASE (Sales Tiers)
SELECT SaleID, CustomerID, SaleAmount,
       CASE
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS TierCategory
FROM Sales;

-- 14. Customers with Invoices but not Sales (EXCEPT)
SELECT CustomerID FROM Invoices
EXCEPT
SELECT CustomerID FROM Sales;

-- 15. CASE (Discount by Quantity)
SELECT CustomerID,
       Quantity,
       CASE
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;
