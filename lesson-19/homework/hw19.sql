CREATE PROCEDURE CalculateEmployeeBonus
AS
BEGIN
    CREATE TABLE #MonthlySales (employee_id INT, sales_amount DECIMAL(10,2));

    -- Misol uchun: Insert #MonthlySales orqali qiymatlar qo‘shiladi

    SELECT e.employee_id, e.name,
           CASE WHEN s.sales_amount >= 10000 
                THEN e.salary * 0.10 ELSE 0 END AS bonus
    FROM Employees e
    LEFT JOIN #MonthlySales s ON e.employee_id = s.employee_id;
END;
GO

CREATE PROCEDURE IncreaseSalaryByDept
    @dept_id INT,
    @percent DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees1
    SET salary = salary + (salary * @percent / 100)
    WHERE department_id = @dept_id;
END;
GO

MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

	SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree;


SELECT 
    s.user_id,
    ISNULL(
        CAST(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 /
             NULLIF(COUNT(c.user_id), 0) AS DECIMAL(3,2)), 0
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;


SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


CREATE OR ALTER PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s
        ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
