--easy level tasks
-- 1
SELECT o.OrderID, c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;

-- 2
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');

-- 3
SELECT d.DepartmentName, MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 4
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;

-- 5
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

-- 6
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');

-- 7
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

--medium level tasks
-- 8
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;

-- 9
SELECT p.ProductName, s.SaleDate, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;

-- 10
SELECT p.ProductName, SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 11
SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' AND e.Salary > 60000;

-- 12
SELECT p.ProductName, s.SaleDate, p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;

-- 13
SELECT e.Name AS EmployeeName, d.DepartmentName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020;

--hard level tasks 
-- 14
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderID, c.Address, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

-- 15
SELECT p.ProductName, p.Category, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = (SELECT CategoryID FROM Categories WHERE CategoryName='Electronics')
   OR s.SaleAmount > 350;

-- 16
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Products p
JOIN Categories c ON p.Category = c.CategoryID
GROUP BY c.CategoryName;

-- 17
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, c.City, o.OrderID, o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;

-- 18
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Human Resources', 'Finance')
   OR (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'a','')) 
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'e','')) 
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'i','')) 
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'o','')) 
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'u',''))) >= 4;

-- 19
SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales','Marketing') AND e.Salary > 60000;
