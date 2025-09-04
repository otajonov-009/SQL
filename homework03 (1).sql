-- ============================
-- Homework 03 SQL Script
-- ============================

-- 🟢 Easy-Level Tasks

-- 1. Define BULK INSERT (Explanation as comment)
-- BULK INSERT is used to import large amounts of data from a file into a table.

-- 2. Four file formats: CSV, TXT, XML, JSON (Explanation as comment)

-- 3. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 4. Insert three records
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Phone', 500.00),
       (2, 'Laptop', 1200.00),
       (3, 'Tablet', 300.00);

-- 5. Difference between NULL and NOT NULL (Explanation as comment)
-- NULL = missing value, NOT NULL = value must be provided.

-- 6. Add UNIQUE constraint to ProductName
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

-- 7. Comment in query
-- Select all products
SELECT * FROM Products;

-- 8. Add CategoryID column
ALTER TABLE Products
ADD CategoryID INT;

-- 9. Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- 10. Purpose of IDENTITY (Explanation as comment)
-- IDENTITY automatically generates incremental values for a column.


-- 🟠 Medium-Level Tasks

-- 1. BULK INSERT from file
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- 2. Create FOREIGN KEY
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- 3. Difference PRIMARY KEY vs UNIQUE KEY (Explanation as comment)
-- PRIMARY KEY: unique, not null. UNIQUE KEY: unique but can have null.

-- 4. CHECK constraint (Price > 0)
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- 5. Add Stock column
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- 6. ISNULL usage
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- 7. FOREIGN KEY explanation (comment)
-- A FOREIGN KEY enforces referential integrity between tables.


-- 🔴 Hard-Level Tasks

-- 1. Customers table with CHECK (Age >= 18)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18)
);

-- 2. Table with IDENTITY (100, 10)
CREATE TABLE Orders (
    OrderID INT IDENTITY(100,10) PRIMARY KEY,
    OrderName VARCHAR(50)
);

-- 3. Composite PRIMARY KEY in OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

-- 4. COALESCE vs ISNULL (Explanation as comment)
-- ISNULL(expr, val) returns val if expr is NULL.
-- COALESCE(expr1, expr2, ...) returns the first non-null value.

-- 5. Employees table with PRIMARY KEY and UNIQUE
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- 6. FOREIGN KEY with CASCADE options
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories_Cascade
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;
