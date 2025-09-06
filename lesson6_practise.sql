-- Lesson 6: Practise Solutions

-- Puzzle 1: Finding Distinct Values (two methods)
-- Method 1: Using DISTINCT with ordering
SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

-- Method 2: Using GROUP BY
SELECT 
       MIN(col1) AS col1,
       MAX(col2) AS col2
FROM InputTbl
GROUP BY 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END;


-- Puzzle 2: Removing Rows with All Zeroes
SELECT *
FROM TestMultipleZero
WHERE NOT (ISNULL(A,0) = 0 AND ISNULL(B,0) = 0 
           AND ISNULL(C,0) = 0 AND ISNULL(D,0) = 0);


-- Puzzle 3: Find those with odd ids
SELECT *
FROM section1
WHERE id % 2 = 1;


-- Puzzle 4: Person with the smallest id
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;


-- Puzzle 5: Person with the highest id
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;


-- Puzzle 6: People whose name starts with b
SELECT *
FROM section1
WHERE name LIKE 'B%';


-- Puzzle 7: Rows where code contains literal underscore "_"
SELECT *
FROM ProductCodes
WHERE Code LIKE '%[_]%';
