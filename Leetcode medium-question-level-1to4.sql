/* LeetCode Medium Level Questions */

/* 1
Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null. */

CREATE TABLE Employee1 (
    id INT,
    salary INT
);

INSERT INTO Employee1 (id, salary) VALUES
(1, 100),
(1, 200),
(1, 300);


WITH salary_rank AS (SELECT 
      salary,
	  DENSE_RANK() OVER (ORDER BY salary DESC) As rnk
FROM Employee1)

SELECT 
       salary
FROM salary_rank
WHERE rnk = 2

SELECT 
     MAX(salary) as SecondHighestSalary

/* 22 
Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

·       The scores should be ranked from the highest to the lowest.

·       If there is  a tie between two scores, both should have the same ranking.

·       After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.

Return the result table ordered by score in descending order.

table name :Scores */

CREATE TABLE Scores (id int, score DECIMAL(3,2));
INSERT INTO Scores (id, score) VALUES 
(1, 3.5),
(2, 3.65),
(3, 4.0),
(4, 3.85),
(5, 4.0),
(6, 3.65);


SELECT 
	  score,
	  DENSE_RANK() OVER (ORDER BY score DESC) as rnk 
FROM Scores


/*
Write an SQL query to find employees who have the highest salary in eah of the departments. 
Return the result table in any order. */

CREATE TABLE Employee (
    id INT,
    name VARCHAR(255),
    salary INT,
    departmentId INT
);

CREATE TABLE Department (
    id INT,
    name VARCHAR(255)
);


INSERT INTO Employee (id, name, salary, departmentId) VALUES (1, 'Joe', 70000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (2, 'Jim', 90000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (3, 'Henry', 80000, 2);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (4, 'Sam', 60000, 2);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (5, 'Max', 90000, 1);

INSERT INTO Department (id, name) VALUES (1, 'IT');
INSERT INTO Department (id, name) VALUES (2, 'Sales');


WITH RankedEmployees AS (
    SELECT 
        RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS rnk,
        e.salary AS Salary,
        d.name AS Department,
        e.name AS Employee
    FROM 
        Employee e
        JOIN Department d ON e.departmentId = d.id
)
SELECT 
    Department,
    Employee,
    Salary 
FROM 
    RankedEmployees 
WHERE 
    rnk = 1;



/*Write an SQL query to report the nth highest salary from the Employee table. 
If there is no nth highest salary, the query should report null. */

CREATE TABLE Employee (
    Id INT,
    Salary INT
);

INSERT INTO Employee (Id, Salary) VALUES
(1, 100),
(2, 200),
(3, 300);

SELECT *
FROM Employee


CREATE FUNCTION getNthNighestSalary(@ INT)
RETURNS INT
AS 
BEGIN 
   DECLARE @result INT;
   
-- Using a CTE to rank salaries

CREATE OR REPLACE FUNCTION getNthHighestSalary(N INT)
RETURNS INT AS $$
DECLARE
    result INT;
BEGIN
    WITH RankedSalaries AS (
        SELECT 
            DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank,
            Salary
        FROM Employee1
    )
    SELECT Salary INTO result FROM RankedSalaries WHERE Rank = N;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

/
