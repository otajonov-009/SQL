-- Beginner-Level Tasks

-- 1. Minimum price of a product
SELECT MIN(Price) AS MinPrice FROM Products;

-- 2. Maximum salary
SELECT MAX(Salary) AS MaxSalary FROM Employees;

-- 3. Count rows in Customers
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- 4. Count unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories FROM Products;

-- 5. Total sales for product with ID 7
SELECT SUM(SaleAmount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;

-- 6. Average age of employees
SELECT AVG(Age) AS AvgAge FROM Employees;

-- 7. Count of employees in each department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 8. Min and max price of products grouped by category
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

-- 9. Total sales per customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- 10. Departments with more than 5 employees
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

-- Medium-Level Tasks

-- 1. Total and average sales per product category
SELECT p.Category, SUM(s.SaleAmount) AS TotalSales, AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- 2. Count employees in HR
SELECT COUNT(*) AS HREmployees
FROM Employees
WHERE DepartmentName = 'HR';

-- 3. Highest and lowest salary by department
SELECT DepartmentName, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

-- 4. Average salary per department
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

-- 5. AVG salary and count of employees per department
SELECT DepartmentName, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 6. Product categories with average price > 400
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- 7. Total sales per year
SELECT YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);

-- 8. Customers with at least 3 orders
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

-- 9. Departments with avg salary > 60000
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

-- Hard-Level Tasks

-- 1. Average price per category > 150
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 2. Total sales per customer > 1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 3. Total and average salary per department, avg salary > 65000
SELECT DepartmentName, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 4. Total amount for orders with freight > 50 & least purchases (requires specific TSQL2012 Orders table)
-- Cannot compute without table details

-- 5. Total sales and unique products per month/year, months with >= 2 products sold
SELECT YEAR(OrderDate) AS SaleYear, MONTH(OrderDate) AS SaleMonth,
       SUM(TotalAmount) AS TotalSales, COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 6. MIN and MAX order quantity per year
SELECT YEAR(OrderDate) AS OrderYear, MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);
