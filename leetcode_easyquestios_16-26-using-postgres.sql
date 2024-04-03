-- Database: leetcode practice

-- DROP DATABASE IF EXISTS "leetcode practice";

CREATE DATABASE "leetcode practice"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE "leetcode practice"
    IS 'This is where all the leet code practice questions go.';
	
/* 16 to 26 * Easy Leetcode questions *? */
/* 16 Write an SQL query to find all the authors that viewed at least one of their own articles. 
Return the result table sorted by id in ascending order. */

CREATE TABLE Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 5, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 6, '2019-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 7, 7, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 7, 6, '2019-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (4, 7, 1, '2019-07-22');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 4, 4, '2019-07-21');

-- The correct syntax for the duplicate entry, assuming you want to insert it only once
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 4, 4, '2019-07-21');


select distinct author_id from [Views]
where author_id = viewer_id 
order by author_id



/* 17 Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED". 
Return the result table in any order. */

CREATE TABLE SalesPerson(
	  sales_id INT,
	  name VARCHAR(255),
	  salary INT,
	  commission_rate INT,
	  hire_date DATE
);

CREATE TABLE Company (
    com_id INT,
    name VARCHAR(255),
    city VARCHAR(255)
);


CREATE TABLE Orders(
	 order_id INT,
	order_date DATE,
	com_id INT,
	sales_id INT,
	amount INT
);

TRUNCATE TABLE SalesPerson;

INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'John', 100000, 6, '2006-04-01');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Amy', 12000, 5, '2010-05-01');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Mark', 65000, 12, '2008-12-25');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'Pam', 25000, 25, '2005-01-01');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (5, 'Alex', 5000, 10, '2007-02-03');

TRUNCATE TABLE Company;

INSERT INTO Company (com_id, name, city) VALUES (1, 'RED', 'Boston');
INSERT INTO Company (com_id, name, city) VALUES (2, 'ORANGE', 'New York');
INSERT INTO Company (com_id, name, city) VALUES (3, 'YELLOW', 'Boston');
INSERT INTO Company (com_id, name, city) VALUES (4, 'GREEN', 'Austin');

TRUNCATE TABLE Orders;

INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (1, '2014-01-01', 3, 4, 10000);
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (2, '2014-02-01', 4, 5, 5000);
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (3, '2014-03-01', 1, 1, 50000);
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (4, '2014-04-01', 1, 4, 25000);

SELECT 
    name FROM SalesPerson
EXCEPT
SELECT 
     s.name
FROM SalesPerson as s
LEFT JOIN Orders o ON o.sales_id = s.sales_id
LEFT JOIN Company C ON c.com_id = o.com_id
WHERE c.Name = 'RED'


WITH RedSales AS (
    SELECT DISTINCT o.sales_id
    FROM Orders o
    JOIN Company c ON o.com_id = c.com_id
    WHERE c.name = 'RED'
)

SELECT s.name
FROM SalesPerson s
WHERE s.sales_id NOT IN (SELECT sales_id FROM RedSales);


/* 18 Write an SQL query to report the largest single number. 
If there is no single number, report null.*/


CREATE TABLE MyNumbers (
    num INT
);

INSERT INTO MyNumbers (num) VALUES (8);
INSERT INTO MyNumbers (num) VALUES (8);
INSERT INTO MyNumbers (num) VALUES (3);
INSERT INTO MyNumbers (num) VALUES (3);
INSERT INTO MyNumbers (num) VALUES (1);
INSERT INTO MyNumbers (num) VALUES (4);
INSERT INTO MyNumbers (num) VALUES (5);
INSERT INTO MyNumbers (num) VALUES (6);



WITH single_numbers AS (
	SELECT 
      num
	FROM MyNumbers
	GROUP BY num
	HAVING COUNT(*) = 1)
	
SELECT 
      MAX(num)
FROM single_numbers
/* 19 
Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table. */

/* --19--
Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table. */
-- Create the Sales table */
CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

-- Create the Product table
CREATE TABLE Product (
    product_id INT,
    product_name VARCHAR(10)
);

-- Insert data into the Sales table
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES (1, 100, 2008, 10, 5000);
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES (2, 100, 2009, 12, 5000);
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES (7, 200, 2011, 15, 9000);

-- Insert data into the Product table
INSERT INTO Product (product_id, product_name) VALUES (100, 'Nokia');
INSERT INTO Product (product_id, product_name) VALUES (200, 'Apple');
INSERT INTO Product (product_id, product_name) VALUES (300, 'Samsung');


SELECT 
     sale_id,
	 product_name,
	 year, 
	 price
FROM Sales s
INNER JOIN Product p ON p.product_id = s.product_id




--20--
/*Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits. */

CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    experience_years INTEGER NOT NULL
);

CREATE TABLE project (
    project_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);


INSERT INTO employee (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 1),
(4, 'Doe', 2);


INSERT INTO project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);


SELECT 
     p.project_id,
	 ROUND(AVG(e.experience_years), 2) AS avg_experience_years
FROM employee e
INNER JOIN project p ON p.employee_id = e.employee_id
GROUP BY p.project_id;


/** 21 * 
A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
Write an SQL query to find the employees who are high earn
Return the result table in any order. */

-- Create tables
CREATE TABLE Employee (id INT, name VARCHAR(255), salary INT, departmentId INT);
CREATE TABLE Department (id INT, name VARCHAR(255));

-- Insert data into Employee table
INSERT INTO Employee (id, name, salary, departmentId) VALUES (1, 'Joe', 85000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (2, 'Henry', 80000, 2);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (3, 'Sam', 60000, 2);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (4, 'Max', 90000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (5, 'Janet', 69000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (6, 'Randy', 85000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (7, 'Will', 70000, 1);

-- Insert data into Department table
INSERT INTO Department (id, name) VALUES (1, 'IT');
INSERT INTO Department (id, name) VALUES (2, 'Sales');

with cte as
(
select d.name as Department,e.name as Employee,e.Salary,dense_rank() over (partition by e.departmentId order by salary desc) as rnk
from Employee as e
join Department as d on e.departmentId = d.id
)
select Department,Employee,Salary from cte where rnk in (1,2,3)

/* 21 */
/*Write an SQL query to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

Return the result table in any order. */

CREATE TABLE Person(personID int, firstName varchar(255), lastName varchar(255));
CREATE TABLE Address (addressId int, personId int, city varchar(255), state varchar(255));

insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen');
-- Correcting the order of names here: assuming 'Alice' is the last name and 'Bob' is the first name.
insert into Person (personId, lastName, firstName) values ('2', 'Bob', 'Alice');

insert into Address (addressId, personId, city, state) values ('1', '1', 'New York City', 'New York');
-- Assuming you meant to insert this address for 'personId' 2, not 3 (as 3 does not exist in Person).
insert into Address (addressId, personId, city, state) values ('2', '2', 'Leetcode', 'California');

SELECT 
     p.firstName,
	 p.lastName,
	 a.state,
	 a.city
	 FROM Person p 
	 LEFT JOIN Address a ON p.personId= a.personId 
	

/* 22 Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. 
Note that you are supposed to write a DELETE statement and not a SELECT one. */

CREATE TABLE IF NOT EXISTS employees(employee_id int, employee_name varchar(255), email_id varchar(255));
TRUNCATE TABLE employees;
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('101','Liam Alton', 'li.al@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('102','Josh Day', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('103','Sean Mann', 'se.ma@abc.com');	
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('104','Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('105','Toby Scott', 'jo.da@abc.com');


WITH ranked_emails AS (
  SELECT employee_id, email_id,
         row_number() OVER (PARTITION BY email_id ORDER BY employee_id) as rn
  FROM employees
)
DELETE FROM employees
WHERE employee_id IN (
  SELECT employee_id FROM ranked_emails WHERE rn > 1
);

/* 23 
Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000. */

-- Creating tables
CREATE TABLE Employee (
    empId int,
    name varchar(255),
    supervisor int,
    salary int
);

CREATE TABLE Bonus (
    empId int,
    bonus int
);

-- Inserting into Employee
INSERT INTO Employee (empId, name, salary) VALUES (3, 'Brad', 4000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (1, 'John', 3, 1000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (2, 'Dan', 3, 2000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (4, 'Thomas', 3, 4000);

-- Inserting into Bonus
INSERT INTO Bonus (empId, bonus) VALUES (2, 500);
INSERT INTO Bonus (empId, bonus) VALUES (4, 2000);

SELECT  
      e.name,
	  b.bonus
FROM Employee e 
LEFT JOIN Bonus b ON b.empId = e.empId
WHERE b.bonus < 1000 or b.bonus is NULL

/* 23 
Write an SQL query to report for every three line segments whether they can form a triangle. */

-- Create the Triangle table
CREATE TABLE Triangle (
    x int,
    y int,
    z int
);

-- Insert values into the Triangle table
INSERT INTO Triangle (x, y, z) VALUES (13, 15, 30);
INSERT INTO Triangle (x, y, z) VALUES (10, 20, 15);

select x,y,z, case when x+y>z and y+z>x and z+x>y then 'Yes' else 'No' end as triangle from triangle

/* 26 Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.
 */
-- Create the Department table
CREATE TABLE Department (
    id int,
    revenue int,
    month varchar(5)
);

-- Insert records into the Department table
INSERT INTO Department (id, revenue, month) VALUES (1, 8000, 'Jan');
INSERT INTO Department (id, revenue, month) VALUES (2, 9000, 'Jan');
INSERT INTO Department (id, revenue, month) VALUES (3, 10000, 'Feb');
INSERT INTO Department (id, revenue, month) VALUES (1, 7000, 'Feb');
INSERT INTO Department (id, revenue, month) VALUES (1, 6000, 'Mar');


SELECT 
    id,
	[Jan] AS [Jan_Revenue],
    [Feb] AS [Feb_Revenue],
    [Mar] AS [Mar_Revenue],
    [Apr] AS [Apr_Revenue],
    [May] AS [May_Revenue],
    [Jun] AS [Jun_Revenue],
    [Jul] AS [Jul_Revenue],
    [Aug] AS [Aug_Revenue],
    [Sep] AS [Sep_Revenue],
    [Oct] AS [Oct_Revenue],
    [Nov] AS [Nov_Revenue],
    [Dec] AS [Dec_Revenue]
FROM
(
    SELECT 
        id, 
        revenue, 
        [month]
    FROM 
        Department3
) AS SourceTable
PIVOT
(
    SUM(revenue)
    FOR [month] IN 
    (
        [Jan],
        [Feb],
        [Mar],
        [Apr],
        [May],
        [Jun],
        [Jul],
        [Aug],
        [Sep],
        [Oct],
        [Nov],
        [Dec]
    )
) AS PivotTable;

