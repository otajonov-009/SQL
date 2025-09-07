-- Easy-Level Tasks
-- 1. Total number of products in each category
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- 2. Average price of 'Electronics' products
SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';

-- 3. Customers from cities starting with 'L'
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Products ending with 'er'
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. Customers from countries ending in 'A'
SELECT *
FROM Customers
WHERE Country LIKE '%a';

-- 6. Highest price among all products
SELECT MAX(Price) AS HighestPrice
FROM Products;

-- 7. Label stock as 'Low Stock' if quantity < 30 else 'Sufficient'
SELECT ProductName,
       CASE 
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Total number of customers in each country
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

-- 9. Minimum and maximum quantity ordered
SELECT MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders;

-- Medium-Level Tasks
-- 1. Customers who placed orders in Jan 2023 but have no invoices
SELECT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i ON o.CustomerID = i.CustomerID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND i.InvoiceID IS NULL;

-- 2. Combine all product names including duplicates
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 3. Combine all product names without duplicates
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Average order amount by year
SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);

-- 5. Group products based on price
SELECT ProductName,
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 6. Pivot City_Population by Year into Population_Each_Year table
SELECT district_name,
       [2012],
       [2013]
INTO Population_Each_Year
FROM 
(
    SELECT district_name, population, year
    FROM City_Population
) src
PIVOT
(
    SUM(population)
    FOR year IN ([2012], [2013])
) AS pvt;

-- 7. Total sales per ProductID
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

-- 8. Products containing 'oo' in the name
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

-- 9. Pivot City_Population by City into Population_Each_City table
SELECT year,
       [Bektemir],
       [Chilonzor],
       [Yakkasaroy]
INTO Population_Each_City
FROM 
(
    SELECT district_name, population, year
    FROM City_Population
) src
PIVOT
(
    SUM(population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS pvt;

-- Hard-Level Tasks
-- 1. Top 3 customers with highest total invoice amount
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 2. Transform Population_Each_Year back to City_Population format
SELECT district_name, population, year
FROM Population_Each_Year
UNPIVOT
(
    population FOR year IN ([2012],[2013])
) AS unpvt;

-- 3. Product names and number of times sold
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

-- 4. Transform Population_Each_City back to City_Population
SELECT district_name, population, year
FROM Population_Each_City
UNPIVOT
(
    population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS unpvt;
