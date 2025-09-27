SELECT r.Region,
       d.Distributor,
       ISNULL(s.Sales,0) AS Sales
FROM (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN #RegionSales s
  ON r.Region = s.Region AND d.Distributor = s.Distributor
ORDER BY r.Region, d.Distributor;

SELECT m.name
FROM Employee m
JOIN Employee e
  ON m.id = e.managerId
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;

SELECT p.product_name,
       SUM(o.unit) AS unit
FROM Products p
JOIN Orders o
  ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date <  '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

WITH VendorCounts AS (
    SELECT CustomerID, Vendor, COUNT(*) AS order_count,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor
FROM VendorCounts
WHERE rn = 1;

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

WITH cte AS (
    SELECT Device_id, Locations,
           COUNT(*) AS cnt
    FROM Device
    GROUP BY Device_id, Locations
),
ranked AS (
    SELECT Device_id, Locations, cnt,
           RANK() OVER (PARTITION BY Device_id ORDER BY cnt DESC) AS rnk
    FROM cte
)
SELECT r.Device_id,
       (SELECT COUNT(DISTINCT Locations) FROM cte c WHERE c.Device_id = r.Device_id) AS no_of_location,
       r.Locations AS max_signal_location,
       (SELECT COUNT(*) FROM Device d WHERE d.Device_id = r.Device_id) AS no_of_signals
FROM ranked r
WHERE r.rnk = 1;

SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employee e2
    WHERE e2.DeptID = e.DeptID
);

WITH ticket_matches AS (
    SELECT t.TicketID, COUNT(DISTINCT t.Number) AS matched
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
)
SELECT SUM(CASE WHEN matched = (SELECT COUNT(*) FROM Numbers) THEN 100
                WHEN matched > 0 THEN 10
                ELSE 0 END) AS TotalWinnings
FROM ticket_matches;

WITH cte AS (
    SELECT Spend_date, User_id,
           MAX(CASE WHEN Platform='Mobile' THEN 1 ELSE 0 END) AS has_mobile,
           MAX(CASE WHEN Platform='Desktop' THEN 1 ELSE 0 END) AS has_desktop,
           SUM(Amount) AS total_amount
    FROM Spending
    GROUP BY Spend_date, User_id
),
classified AS (
    SELECT Spend_date,
           CASE WHEN has_mobile=1 AND has_desktop=1 THEN 'Both'
                WHEN has_mobile=1 AND has_desktop=0 THEN 'Mobile'
                WHEN has_mobile=0 AND has_desktop=1 THEN 'Desktop'
           END AS Platform,
           total_amount
    FROM cte
)
SELECT ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
       Spend_date, Platform,
       SUM(total_amount) AS Total_Amount,
       COUNT(*) AS Total_users
FROM classified
GROUP BY Spend_date, Platform;

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Numbers WHERE n < 100
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
