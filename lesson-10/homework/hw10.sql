-- EASY LEVEL (9)

-- 1. Employees & Departments – 50000 dan katta oyliklar
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;

-- 2. Customers & Orders – 2023-yildagi buyurtmalar
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;

-- 3. Employees & Departments – barcha xodimlar (department bo‘lmasa ham)
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 4. Suppliers & Products – barcha supplier va mahsulotlari (hatto bo‘lmasa ham)
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;

-- 5. Orders & Payments – barcha buyurtma va to‘lovlar (ikkala tomondan)
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID;

-- 6. Employees – manageri bilan
SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- 7. Students & Courses – "Math 101" ga yozilgan talabalar
SELECT s.Name AS StudentName, c.CourseName
FROM Students s
JOIN Enrollments en ON s.StudentID = en.StudentID
JOIN Courses c ON en.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';

-- 8. Customers & Orders – 3 tadan ko‘p buyurtma qilganlar
SELECT c.FirstName, c.LastName, o.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;

-- 9. Employees & Departments – "Human Resources" dagilar
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';



-- MEDIUM LEVEL (9)

-- 10. Customers – buyurtmalar soni bilan
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 11. Employees – eng yuqori oylikli xodim va department
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (SELECT MAX(Salary) FROM Employees);

-- 12. Orders – har bir buyurtmaning umumiy summasi
SELECT o.OrderID, SUM(oi.Quantity * p.Price) AS TotalAmount
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID;

-- 13. Employees – har bir department bo‘yicha o‘rtacha oylik
SELECT d.DepartmentName, AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 14. Students & Courses – kursga yozilmagan talabalar
SELECT s.Name
FROM Students s
LEFT JOIN Enrollments en ON s.StudentID = en.StudentID
WHERE en.CourseID IS NULL;

-- 15. Products & Suppliers – eng qimmat mahsulot va supplier
SELECT p.ProductName, p.Price, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.Price = (SELECT MAX(Price) FROM Products);

-- 16. Orders & Payments – hali to‘lanmagan buyurtmalar
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

-- 17. Employees – har bir manager qo‘l ostidagi xodimlar soni
SELECT m.Name AS ManagerName, COUNT(e.EmployeeID) AS SubordinateCount
FROM Employees m
JOIN Employees e ON m.EmployeeID = e.ManagerID
GROUP BY m.Name;

-- 18. Courses – har bir kursga yozilgan talabalar soni
SELECT c.CourseName, COUNT(en.StudentID) AS StudentCount
FROM Courses c
LEFT JOIN Enrollments en ON c.CourseID = en.CourseID
GROUP BY c.CourseName;



-- HARD LEVEL (9)

-- 19. Employees – departmentdagi eng yuqori oylik va xodim
SELECT d.DepartmentName, e.Name, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (
    SELECT MAX(Salary) 
    FROM Employees 
    WHERE DepartmentID = d.DepartmentID
);

-- 20. Customers – eng ko‘p buyurtma qilgan mijoz
SELECT TOP 1 c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY OrderCount DESC;

-- 21. Products – hech kim buyurtma qilmagan mahsulotlar
SELECT p.ProductName
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
WHERE oi.OrderID IS NULL;

-- 22. Employees – eng ko‘p xodim ishlaydigan department
SELECT TOP 1 d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY EmployeeCount DESC;

-- 23. Orders – eng katta summali buyurtma
SELECT TOP 1 o.OrderID, SUM(oi.Quantity * p.Price) AS TotalAmount
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID
ORDER BY TotalAmount DESC;

-- 24. Students – eng ko‘p kursga yozilgan talaba
SELECT TOP 1 s.Name, COUNT(en.CourseID) AS CourseCount
FROM Students s
JOIN Enrollments en ON s.StudentID = en.StudentID
GROUP BY s.Name
ORDER BY CourseCount DESC;

-- 25. Employees – o‘z manageridan yuqori oylikka ega xodimlar
SELECT e.Name AS EmployeeName, e.Salary, m.Name AS ManagerName, m.Salary AS ManagerSalary
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;

-- 26. Suppliers – eng ko‘p mahsulot yetkazib beruvchi supplier
SELECT TOP 1 s.SupplierName, COUNT(p.ProductID) AS ProductCount
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierName
ORDER BY ProductCount DESC;

-- 27. Customers – eng ko‘p pul sarflagan mijoz
SELECT TOP 1 c.FirstName, c.LastName, SUM(p.Amount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Payments p ON o.OrderID = p.OrderID
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpent DESC;
