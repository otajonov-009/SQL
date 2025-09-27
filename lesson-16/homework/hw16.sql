;with cte as(
select 1 as num
union all
select num + 1
from cte
where num<1000)
select num from cte
option (maxrecursion 1000)


select emp2.EmployeeID,emp2.FirstName,emp2.LastName ,emp.sum_sales from (
select EmployeeID, sum(SalesAmount) as sum_sales   from Sales
group by EmployeeID) as emp
join Employees as emp2
on emp.EmployeeID = emp2.EmployeeID

;with cte as(
select avg(Salary)as avg_salary from Employees)
select avg_salary
from cte

select*from Sales
select*from Products

select top 1*from(
select ProductID,max(SalesAmount)as max_amount from Sales
group by ProductID) as amount
join Products
on amount.ProductID = Products.ProductID
order by max_amount desc

;with cte as (
select 1 as n
union all
select n * 2
from cte
where n * 2 < 1000000)
select n from cte
option (maxrecursion 0)

;with cte as(
select EmployeeID,count(ProductID) as total_sales from Sales
group by EmployeeID)
select*from cte
join Employees
on cte.EmployeeID = Employees.EmployeeID
where total_sales > 5

;with cte as (
select ProductID,sum(SalesAmount)as sum_amount from sales
group by ProductID)
select*from cte
join Products
on cte.ProductID = Products.ProductID
where sum_amount > 500

;WITH cte AS (
    SELECT AVG(Salary) AS avg_salary
    FROM Employees
)
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary
FROM Employees e
CROSS JOIN cte
WHERE e.Salary > cte.avg_salary;

SELECT TOP 5 e.EmployeeID, e.FirstName, e.LastName, emp_orders.total_orders
FROM (
    SELECT EmployeeID, COUNT(SalesID) AS total_orders
     FROM Sales
    GROUP BY EmployeeID
) AS emp_orders
JOIN Employees e
    ON emp_orders.EmployeeID = e.EmployeeID
ORDER BY emp_orders.total_orders DESC;

SELECT dt.CategoryID, SUM(dt.SalesAmount) AS total_sales
FROM (
    SELECT s.SalesAmount, p.CategoryID
    FROM Sales s
    JOIN Products p
        ON s.ProductID = p.ProductID
) AS dt
GROUP BY dt.CategoryID
ORDER BY total_sales DESC

;WITH FactorialCTE AS (
  SELECT Number AS n, 1 AS i,  1 AS fact
  FROM Numbers1
  UNION ALL     
  SELECT n, i + 1,fact * (i + 1)
  FROM FactorialCTE     
   WHERE i < n)
SELECT n AS Number,MAX(fact) AS Factorial
FROM FactorialCTE 
GROUP BY n    
ORDER BY n

select*from string_split('string','.') Example
select*from Example

;WITH cte AS (
    SELECT  Id, CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS Ch,1 AS Pos,String
    FROM Example
    UNION ALL
    SELECT  Id,CAST(SUBSTRING(String, Pos + 1, 1) AS VARCHAR(1)) AS Ch, Pos + 1, String
    FROM cte   
    WHERE Pos < LEN(String))    
SELECT Id, Ch
FROM cte
ORDER BY Id, Pos; 

;WITH MonthlySales AS (   
 SELECT YEAR(SaleDate) AS SalesYear,MONTH(SaleDate) AS SalesMonth,SUM(SalesAmount) AS TotalSales
 FROM Sales       
 GROUP BY YEAR(SaleDate), MONTH(SaleDate)),       
DiffCTE AS (
    SELECT 
        m1.SalesYear,
        m1.SalesMonth,
        m1.TotalSales AS CurrentMonthSales,
        LAG(m1.TotalSales) OVER (ORDER BY m1.SalesYear, m1.SalesMonth) AS PreviousMonthSales
    FROM MonthlySales m1)
SELECT 
    SalesYear,
    SalesMonth,
    CurrentMonthSales,
    PreviousMonthSales,
    (CurrentMonthSales - PreviousMonthSales) AS Difference
FROM DiffCTE
WHERE PreviousMonthSales IS NOT NULL

select*from sales
select*from employees

SELECT e.EmployeeID, e.FirstName, e.LastName,
       CASE 
         WHEN MONTH(s.SaleDate) BETWEEN 1 AND 3 THEN 'Q1'
         WHEN MONTH(s.SaleDate) BETWEEN 4 AND 6 THEN 'Q2'
         WHEN MONTH(s.SaleDate) BETWEEN 7 AND 9 THEN 'Q3'
         ELSE 'Q4'
       END AS Quarter,
       SUM(e.Salary) AS TotalSalary
FROM Employees e
JOIN Sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName,
         CASE 
           WHEN MONTH(s.SaleDate) BETWEEN 1 AND 3 THEN 'Q1'
           WHEN MONTH(s.SaleDate) BETWEEN 4 AND 6 THEN 'Q2'
           WHEN MONTH(s.SaleDate) BETWEEN 7 AND 9 THEN 'Q3'
           ELSE 'Q4'
         END
HAVING SUM(e.Salary) > 45000
ORDER BY e.EmployeeID, Quarter;

;WITH Fibonacci (n, a, b) AS (
    SELECT 1, 0, 1  
    UNION ALL
    SELECT n + 1, b, a + b
    FROM Fibonacci
    WHERE n < 15  )
SELECT n, a AS FibonacciNumber
FROM Fibonacci;

SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND LEN(REPLACE(Vals, LEFT(Vals,1), '')) = 0;


DECLARE @n INT = 5;

;WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(50)) AS seq
    UNION ALL
    SELECT num + 1, CAST(seq + CAST(num + 1 AS VARCHAR(50)) AS VARCHAR(50))
    FROM Numbers
    WHERE num < @n
)
SELECT seq
FROM Numbers
OPTION (MAXRECURSION 0);
 


;WITH Last6Months AS (
    SELECT *
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
),
EmployeeSales AS (
    SELECT e.EmployeeID, e.FirstName, e.LastName,
           SUM(s.SalesAmount) AS TotalSales
    FROM Last6Months s
    JOIN Employees e ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT TOP 5 *
FROM EmployeeSales
ORDER BY TotalSales DESC;

;WITH SplitData AS (
    SELECT Id = PawanName,
           LEFT(Pawan_slug_name, CHARINDEX('-', Pawan_slug_name)) AS Prefix,
           RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) AS Numbers
    FROM RemoveDuplicateIntsFromNames
),
CheckNums AS (
    SELECT Id, Prefix, Numbers,
           LEN(Numbers) AS L,
           LEN(REPLACE(Numbers, LEFT(Numbers,1), '')) AS Diff
    FROM SplitData
)
SELECT Id,
       CASE 
          WHEN LEN(Numbers)=1 THEN Prefix   
          WHEN LEN(Numbers) = Diff THEN Prefix  
          ELSE Prefix + Numbers 
       END AS CleanedValue
FROM CheckNums;
