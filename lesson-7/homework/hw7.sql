-- Lesson 7: Homework Solutions

-- Easy Level Tasks

-- 1. Write a query to select the top 5 employees from the Employees table.
SELECT TOP 5 * FROM Employees;

-- 2. Use SELECT DISTINCT to select unique Category values from the Products table.
SELECT DISTINCT Category FROM Products;

-- 3. Write a query that filters the Products table to show products with Price > 100.
SELECT * FROM Products WHERE Price > 100;

-- 4. Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
SELECT * FROM Customers WHERE FirstName LIKE 'A%';

-- 5. Order the results of a Products table by Price in ascending order.
SELECT * FROM Products ORDER BY Price ASC;

-- 6. Write a query that uses the WHERE clause to filter for employees with Salary >= 50000.
SELECT * FROM Employees WHERE Salary >= 50000;

-- 7. Select all columns from the Orders table where Quantity is greater than 10.
SELECT * FROM Orders WHERE Quantity > 10;

-- 8. Write a query to select the ProductName and Price from Products where Price is between 50 and 200.
SELECT ProductName, Price FROM Products WHERE Price BETWEEN 50 AND 200;

-- 9. Write a query that returns all Customers from 'Tashkent' city.
SELECT * FROM Customers WHERE City = 'Tashkent';

-- 10. Use the IN operator to select employees from Departments 1, 2, and 3.
SELECT * FROM Employees WHERE DepartmentID IN (1,2,3);


-- Medium Level Tasks 

-- 11. Write a query that finds the total number of employees in the Employees table.
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- 12. Write a query that calculates the average Price of products in the Products table.
SELECT AVG(Price) AS AvgPrice FROM Products;

-- 13. Write a query that finds the maximum Salary from Employees.
SELECT MAX(Salary) AS MaxSalary FROM Employees;

-- 14. Write a query that finds the minimum Quantity from Orders.
SELECT MIN(Quantity) AS MinQuantity FROM Orders;

-- 15. Write a query to group Customers by City.
SELECT City, COUNT(*) AS TotalCustomers FROM Customers GROUP BY City;

-- 16. Write a query that joins Orders and Products tables on ProductID.
SELECT o.OrderID, p.ProductName, o.Quantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID;

-- 17. Write a query to find employees whose Salary is greater than the average Salary.
SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 18. Write a query that returns Customers and their Orders using INNER JOIN.
SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 19. Write a query that returns all Customers and their Orders using LEFT JOIN.
SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- Hard Level Tasks 

-- 20. Write a query to find the top 3 highest paid employees.
SELECT TOP 3 * FROM Employees ORDER BY Salary DESC;

-- 21. Write a query that finds the total sales amount (Quantity * Price) for each Product.
SELECT p.ProductID, p.ProductName, SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName;

-- 22. Write a query that returns Customers who have not placed any Orders.
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- 23. Write a query that returns the second highest Salary from Employees.
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

-- 24. Write a query to update all Employees in DepartmentID = 2 with a 10% Salary increase.
UPDATE Employees
SET Salary = Salary * 1.1
WHERE DepartmentID = 2;

-- 25. Write a query to delete Orders where Quantity = 0.
DELETE FROM Orders WHERE Quantity = 0;

-- 26. Create a view that shows CustomerName, ProductName, and Quantity from Customers, Orders, and Products tables.
CREATE VIEW CustomerOrdersView AS
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, p.ProductName, o.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID;
