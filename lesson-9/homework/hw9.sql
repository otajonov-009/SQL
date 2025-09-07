--easy level tasks
-- 1. Products va Suppliers: barcha kombinatsiyalar
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

-- 2. Departments va Employees: barcha kombinatsiyalar
SELECT D.DepartmentName, E.Name
FROM Departments D
CROSS JOIN Employees E;

-- 3. Products va Suppliers: faqat haqiqiy ta’minotchi
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S
ON P.SupplierID = S.SupplierID;

-- 4. Orders va Customers: customer va order
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID;

-- 5. Courses va Students: barcha kombinatsiyalar
SELECT S.Name AS StudentName, C.CourseName
FROM Students S
CROSS JOIN Courses C;

-- 6. Products va Orders: product va order
SELECT P.ProductName, O.OrderID
FROM Products P
INNER JOIN Orders O
ON P.ProductID = O.ProductID;

-- 7. Departments va Employees: mos department
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D
ON E.DepartmentID = D.DepartmentID;

-- 8. Students va Enrollments
SELECT S.Name AS StudentName, E.CourseID
FROM Students S
INNER JOIN Enrollments E
ON S.StudentID = E.StudentID;

-- 9. Payments va Orders: matching orders
SELECT O.OrderID, P.PaymentID
FROM Orders O
INNER JOIN Payments P
ON O.OrderID = P.OrderID;

-- 10. Orders va Products: price > 100
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
INNER JOIN Products P
ON O.ProductID = P.ProductID
WHERE P.Price > 100;

--medium level tasks

-- 11. Employees va Departments: department mismatch
SELECT E.Name, D.DepartmentName
FROM Employees E
CROSS JOIN Departments D
WHERE E.DepartmentID <> D.DepartmentID;

-- 12. Orders va Products: ordered quantity > stock
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
INNER JOIN Products P
ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;

-- 13. Customers va Sales: sale amount >= 500
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, S.ProductID
FROM Customers C
INNER JOIN Sales S
ON C.CustomerID = S.CustomerID
WHERE S.SaleAmount >= 500;

-- 14. Courses, Enrollments, Students: enrolled courses
SELECT ST.Name AS StudentName, C.CourseName
FROM Students ST
INNER JOIN Enrollments E
ON ST.StudentID = E.StudentID
INNER JOIN Courses C
ON E.CourseID = C.CourseID;

-- 15. Products va Suppliers: supplier name contains 'Tech'
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S
ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

-- 16. Orders va Payments: payment < total amount
SELECT O.OrderID, O.TotalAmount, P.Amount AS PaidAmount
FROM Orders O
INNER JOIN Payments P
ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;

-- 17. Employees va Departments: get department name
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D
ON E.DepartmentID = D.DepartmentID;

-- 18. Products va Categories: category Electronics/Furniture
SELECT P.ProductName, P.Category
FROM Products P
INNER JOIN Categories C
ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics','Furniture');

-- 19. Sales va Customers: customers from USA
SELECT S.SaleID, C.FirstName + ' ' + C.LastName AS CustomerName
FROM Sales S
INNER JOIN Customers C
ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';

-- 20. Orders va Customers: Germany & total > 100
SELECT O.OrderID, C.FirstName + ' ' + C.LastName AS CustomerName, O.TotalAmount
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;

--hard level tasks

-- 21. Employees pairs from different departments
SELECT E1.Name AS Employee1, E2.Name AS Employee2
FROM Employees E1
INNER JOIN Employees E2
ON E1.DepartmentID <> E2.DepartmentID
AND E1.EmployeeID < E2.EmployeeID;

-- 22. Payments, Orders, Products: paid != qty * price
SELECT P.PaymentID, O.OrderID, O.Quantity, PR.Price, P.Amount AS PaidAmount
FROM Payments P
INNER JOIN Orders O
ON P.OrderID = O.OrderID
INNER JOIN Products PR
ON O.ProductID = PR.ProductID
WHERE P.Amount <> O.Quantity * PR.Price;

-- 23. Students not enrolled in any course
SELECT S.Name
FROM Students S
LEFT JOIN Enrollments E
ON S.StudentID = E.StudentID
WHERE E.EnrollmentID IS NULL;

-- 24. Employees who are managers but salary <= subordinate
SELECT M.Name AS Manager, E.Name AS Subordinate, M.Salary AS ManagerSalary, E.Salary AS SubordinateSalary
FROM Employees M
INNER JOIN Employees E
ON M.EmployeeID = E.ManagerID
WHERE M.Salary <= E.Salary;

-- 25. Customers who made order but no payment
SELECT DISTINCT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
LEFT JOIN Payments P
ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;

