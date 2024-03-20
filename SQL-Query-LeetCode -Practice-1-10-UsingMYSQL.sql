/* Question 1:
Write an SQL query to find the employees who earn more than their managers. 
Return the result table in any order. */

CREATE TABLE [dbo].[employee](
	[id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[salary] [int] NULL,
	[managerId] [int] NULL,
 CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)
) ON [PRIMARY]
GO
INSERT [dbo].[employee] ([id], [name], [salary], [managerId]) VALUES (1, N'Joe', 70000, 3)
GO
INSERT [dbo].[employee] ([id], [name], [salary], [managerId]) VALUES (2, N'Henry', 80000, 4)
GO
INSERT [dbo].[employee] ([id], [name], [salary], [managerId]) VALUES (3, N'Sam', 60000, NULL)
GO
INSERT [dbo].[employee] ([id], [name], [salary], [managerId]) VALUES (4, N'Max', 90000, NULL)
GO

--method-a
-- Using Inner Join--

SELECT 
     e.name
FROM employee e 
INNER JOIN employee m ON e.managerId = m.id
WHERE e.salary > m.salary

--method --b
SELECT e.name from employee as e
left join employee as e1 on e.managerID = e1.id
where e.salary > e1.salary


--Question --2 
/* Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL. 
Return the result table in any order. */

CREATE TABLE [dbo].[Person](
	[id] [int] NOT NULL,
	[email] [varchar](150) NULL,
)
GO
INSERT [dbo].[Person] ([id], [email]) VALUES (1, N'a@b.com')
GO
INSERT [dbo].[Person] ([id], [email]) VALUES (2, N'c@d.com')
GO
INSERT [dbo].[Person] ([id], [email]) VALUES (3, N'a@b.com')
GO

SELECT 
     email
FROM Person 
GROUP BY email
HAVING COUNT(email) > 1


/* Question 3: 
Write an SQL query to report all customers who never order anything. 
Return the result table in any order. */

CREATE TABLE [dbo].[Customers](

[id][int] NOT NULL,

[name][varchar](50) NULL,

 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 

(

   [id]
ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]

GO

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO

CREATE TABLE [dbo].[Orders](

[id][int] NOT NULL, 

[customerId][int] NULL,

 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 

(

       [id]
ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]

GO

INSERT [dbo].[Customers] ([id], [name]) VALUES (1, N'Joe')

GO

INSERT [dbo].[Customers] ([id], [name]) VALUES (2, N'Henry')

GO

INSERT [dbo].[Customers] ([id], [name]) VALUES (3, N'Sam')

GO

INSERT [dbo].[Customers] ([id], [name]) VALUES (4, N'Max')

GO

INSERT [dbo].[Orders] ([id], [customerId]) VALUES (1, 3)

GO

INSERT [dbo].[Orders] ([id], [customerId]) VALUES (2, 1)

GO

SELECT   
      c.name
FROM Customers c 
LEFT JOIN Orders o ON o.customerId = c.id
WHERE o.id IS NULL



--Question 4 --
/* Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday). 
Return the result table in any order. */

CREATE TABLE [dbo].[Weather](
       [id][int] NOT NULL,
       [recordDate][date] NULL,
       [temperature][int] NULL,
 CONSTRAINT [PK_Weather] PRIMARY KEY CLUSTERED
(
       [id]
ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Weather] ([id], [recordDate], [temperature]) VALUES (1, CAST(N'2015-01-01' AS Date), 10)
GO
INSERT [dbo].[Weather] ([id], [recordDate], [temperature]) VALUES (2, CAST(N'2015-01-02' AS Date), 25)
GO
INSERT [dbo].[Weather] ([id], [recordDate], [temperature]) VALUES (3, CAST(N'2015-01-03' AS Date), 20)
GO
INSERT [dbo].[Weather] ([id], [recordDate], [temperature]) VALUES (4, CAST(N'2015-01-04' AS Date), 30)
GO



WITH PreviousTemperature AS (SELECT 
	  *,
	  LAG(temperature) OVER (ORDER BY recordDate) AS previous_temperature
FROM Weather)

SELECT
      w1.id
FROM 
    weather w1
INNER JOIN PreviousTemperature w2 ON w1.id = w2.id
WHERE w1.temperature  > w2.previous_temperature

--Question 5 --

/* Write an SQL query to report the first login date for each player. 
Return the result table in any order. */

CREATE TABLE [dbo].[Activity](
       [player_id][int] NULL,
       [device_id][int] NULL,
       [event_date][date] NULL,
       [games_played][int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Activity] ([player_id], [device_id], [event_date], [games_played]) VALUES (1, 2, CAST(N'2016-03-01' AS Date), 5)
GO
INSERT [dbo].[Activity] ([player_id], [device_id], [event_date], [games_played]) VALUES (1, 2, CAST(N'2016-05-02' AS Date), 6)
GO
INSERT [dbo].[Activity] ([player_id], [device_id], [event_date], [games_played]) VALUES (2, 3, CAST(N'2017-06-25' AS Date), 1)
GO
INSERT [dbo].[Activity] ([player_id], [device_id], [event_date], [games_played]) VALUES (3, 1, CAST(N'2016-03-02' AS Date), 0)
GO
INSERT [dbo].[Activity] ([player_id], [device_id], [event_date], [games_played]) VALUES (3, 4, CAST(N'2018-07-03' AS Date), 5)
GO

SELECT 
    player_id,
     Min(event_date) as  first_login
FROM Activity
GROUP BY player_id

/* Question --6-- */
/*Write an SQL query to report the names of the customer that are not referred by the customer with id = 2. 
Return the result table in any order. */

CREATE TABLE [dbo].[Customers](
       [id][int] NOT NULL,
       [name][varchar](50) NULL,
       [referee_id][int] NULL,
 CONSTRAINT [PK_Customres1] PRIMARY KEY CLUSTERED
(
       [id]
ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Customers] ([id], [name], [referee_id]) VALUES (1, N'Will', NULL)
GO
INSERT [dbo].[Customers] ([id], [name], [referee_id]) VALUES (2, N'Jane', NULL)
GO
INSERT [dbo].[Customers] ([id], [name], [referee_id]) VALUES (3, N'Alex', 2)
GO
INSERT [dbo].[Customers] ([id], [name], [referee_id]) VALUES (4, N'Bill', NULL)
GO
INSERT [dbo].[Customers] ([id], [name], [referee_id]) VALUES (5, N'Zack', 1)
GO
INSERT [dbo].[Customers] ([id], [name], [referee_id]) VALUES (6, N'Mark', 2)
GO

SELECT *
FROM Customers
WHERE referee_id<> 2 OR referee_id IS NULL

/* Question 7 */
/* Write an SQL query to find the customer_number for the customer who has placed the largest number of orders. */

CREATE TABLE [dbo].[Orders](
       [order_number]
[int] NULL,
       [customer_number]
[int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Orders] ([order_number], [customer_number]) VALUES (1, 1)
GO
INSERT [dbo].[Orders] ([order_number], [customer_number]) VALUES (2, 2)
GO
INSERT [dbo].[Orders] ([order_number], [customer_number]) VALUES (3, 3)
GO
INSERT [dbo].[Orders] ([order_number], [customer_number]) VALUES (4, 3)
GO

WITH c_ordercount AS ( 
      SELECT customer_number, COUNT(*) AS order_count
	  FROM Orders
	  GROUP BY customer_number
)
SELECT 
     customer_number
FROM c_ordercount
WHERE 
     order_count = (SELECT MAX(order_count) FROM c_ordercount)


/* Question 8: 
Write an SQL query to report the name, population, and area of the big countries. 
Return the result table in any order. 
A country is big if:

·       it has an area of at least three million (i.e., 3000000 km2), or

·       it has a population of at least twenty-five million (i.e., 25000000).*/


CREATE TABLE [dbo].[World](
       [name][varchar](50) NOT NULL,
       [continent][varchar](50) NULL,
       [area][int] NULL,
       [population][int] NULL,
       [gdp][bigint] NULL,
 CONSTRAINT [PK_World] PRIMARY KEY CLUSTERED
(
       [name]
ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[World] ([name], [continent], [area], [population], [gdp]) VALUES (N'Afghanistan', N'Asia', 652230, 25500100, 20343000000)
GO
INSERT [dbo].[World] ([name], [continent], [area], [population], [gdp]) VALUES (N'Albania', N'Europe', 28748, 2831741, 12960000000)
GO
INSERT [dbo].[World] ([name], [continent], [area], [population], [gdp]) VALUES (N'Algeria', N'Africa', 2381741, 37100000, 188681000000)
GO
INSERT [dbo].[World] ([name], [continent], [area], [population], [gdp]) VALUES (N'Andorra', N'Europe', 468, 7811, 3712000000)
GO
INSERT [dbo].[World] ([name], [continent], [area], [population], [gdp]) VALUES (N'Angola', N'Africa', 1246700, 20609294, 100990000000)
GO


SELECT 
      name, 
	  population,
	  area
FROM World
WHERE 
      area >= 300000 and population >=25000000


/* Question --9-- */

/* Write an SQL query to report all the classes that have at least five students. 
Return the result table in any order. */

CREATE TABLE [dbo].[courses](
       [student][varchar](50) NULL,
       [class][varchar](50) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'A', N'Math')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'B', N'English')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'C', N'Math')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'D', N'Biology')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'E', N'Math')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'F', N'Computer')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'G', N'Math')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'H', N'Math')
GO
INSERT [dbo].[courses] ([student], [class]) VALUES (N'I', N'Math')
GO

SELECT 
      class
FROM courses
GROUP BY class
HAVING count(student) >= 5


/* Question --10-- */
/* Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring". 
Return the result table ordered by rating in descending order. */

CREATE TABLE [dbo].[Cinema](
       [id][int] NOT NULL,
       [movie][varchar](50) NULL,
       [description][varchar](50) NULL,
       [rating][float] NULL,
 CONSTRAINT [PK_Cinema] PRIMARY KEY CLUSTERED
(
       [id]
ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Cinema] ([id], [movie], [description], [rating]) VALUES (1, N'War', N'great 3D', 8.9)
GO
INSERT [dbo].[Cinema] ([id], [movie], [description], [rating]) VALUES (2, N'Science', N'fiction', 8.5)
GO
INSERT [dbo].[Cinema] ([id], [movie], [description], [rating]) VALUES (3, N'irish', N'boring', 6.2)
GO
INSERT [dbo].[Cinema] ([id], [movie], [description], [rating]) VALUES (4, N'Ice song', N'Fantacy', 8.6)
GO
INSERT [dbo].[Cinema] ([id], [movie], [description], [rating]) VALUES (5, N'House card', N'Interesting ', 9.1)
GO

SELECT 
      movie
FROM Cinema
WHERE id % 2 = 1 AND description <> 'boring'
ORDER BY rating desc;

