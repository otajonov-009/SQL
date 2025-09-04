-- 1. Employees jadvalini yaratish
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. Uchta yozuv qo‘shish
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali', 5000);

INSERT INTO Employees
VALUES (2, 'Vali', 6000);

INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(3, 'Hasan', 4500),
(4, 'Husan', 5500);

-- 3. EmpID = 1 bo‘lgan xodimning oyligini 7000 ga o‘zgartirish
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 4. EmpID = 2 bo‘lgan xodimni o‘chirish
DELETE FROM Employees
WHERE EmpID = 2;

-- 5. DELETE, TRUNCATE, DROP farqi
-- DELETE: Jadvaldan tanlangan ma’lumotlarni o‘chiradi (ROLLBACK qilish mumkin).
-- TRUNCATE: Jadvaldagi barcha ma’lumotlarni o‘chiradi, lekin tuzilma qoladi (ROLLBACK qilish mumkin emas).
-- DROP: Butun jadvalni o‘chiradi (strukturasi ham o'chib ketadi).

-- 6. Name ustunini VARCHAR(100) ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 7. Department ustunini qo‘shish
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Salary ustunini FLOAT ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 9. Departments jadvalini yaratish
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Employees jadvalidan barcha ma’lumotlarni o‘chirish (strukturasi saqlanadi)
TRUNCATE TABLE Employees;
-- 11. Departments jadvaliga 5 ta yozuv qo‘shish (INSERT INTO SELECT)
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'IT' UNION ALL
SELECT 3, 'Finance' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'Management';

-- 12. Salary > 5000 bo‘lgan xodimlarga Department = 'Management' qilish
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 13. Employees jadvalidan barcha xodimlarni o‘chirish (strukturasi saqlanadi)
TRUNCATE TABLE Employees;

-- 14. Employees jadvalidan Department ustunini o‘chirish
ALTER TABLE Employees
DROP COLUMN Department;

-- 15. Employees jadvalini StaffMembers deb nomlash
EXEC sp_rename 'Employees', 'StaffMembers';

-- 16. Departments jadvalini butunlay o‘chirish
DROP TABLE Departments;
-- 17. Products jadvalini yaratish
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(200)
);

-- 18. Price > 0 CHECK constraint qo‘shish
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- 19. StockQuantity ustuni DEFAULT 50 bilan qo‘shish
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 20. Category ustunini ProductCategory deb nomlash
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21. Products jadvaliga 5 ta yozuv qo‘shish
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1200.50, 'Business Laptop'),
(2, 'Phone', 'Electronics', 800.00, 'Smartphone'),
(3, 'Table', 'Furniture', 150.75, 'Wooden Table'),
(4, 'Chair', 'Furniture', 75.00, 'Office Chair'),
(5, 'Shoes', 'Fashion', 55.50, 'Running Shoes');

-- 22. Products_Backup jadvalini SELECT INTO bilan yaratish
SELECT * INTO Products_Backup
FROM Products;

-- 23. Products jadvalini Inventory deb nomlash
EXEC sp_rename 'Products', 'Inventory';

-- 24. Inventory jadvalidagi Price ustunini FLOAT ga o‘zgartirish
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 25. ProductCode IDENTITY ustunini qo‘shish (1000 dan boshlanadi, 5 ga oshib boradi)
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);
