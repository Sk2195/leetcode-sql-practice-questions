/* Practicing SQL Queries */

CREATE TABLE [dbo].[employee](
       [id] [int] NOT NULL,
	   [name] [varchar] (50) NULL,
	   [salary] [int] NULL,
	   [managerID] [int] NULL,
  CONSTRAINT [Pk_employee] PRIMARY KEY CLUSTERED 
  (
    [id] ASC
)
) ON [PRIMARY]
GO
INSERT [dbo].employee ([id], [name], [salary], [managerID])
    VALUES (1, N'Joe', 70000, 3)
GO
INSERT [dbo].[employee] ([id], [name], [salary], [managerID])
     VALUES(2, N'Henry', 80000, 4)
GO
INSERT [dbo].[employee] ([id], [name], [salary], [managerID])
     VALUES (3, N'Sam', 60000, NULL)
INSERT [dbo].[employee] ([id], [name], [salary], [managerID])
	  VALUES (4, N'Max', 90000, NULL)
GO

SELECT 
      e.name
FROM employee e
LEFT JOIN employee m ON e.managerID = m.id
WHERE e.salary > m.salary

/* Practice SQL Queries */
--Question --2 

CREATE TABLE [dbo].[Person](
       [id] [int] NOT NULL,
	   [email] [varchar] (150) NULL,
)
GO
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
*
FROM person

SELECT
     email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1

/* Question 3:  */

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
INSERT [dbo].[Orders] ([id], [customerId])
     VALUES(2, 1)
GO

SELECT    c. name as customers
FROM  Customers c
LEFT JOIN Orders o ON o.customerId = c.id
WHERE o.id  IS NULL


---Question 4
/*  */

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

WITH TemperatureDifferences AS (
       SELECT 
	          *,
		LAG(temperature, 1) OVER (ORDER BY recordDate) AS prev_temperature
FROM dbo.Weather)

SELECT 
      recordDate
FROM TemperatureDifferences
WHERE temperature > prev_temperature

--Question 5-
/*Write an SQL query to report the first login date for each player. Return the result table in any order.
*/
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

WITH ranked_dates AS (
   SELECT 
       *,
      RANK() OVER (
	      PARTITION BY (player_id)
		  ORDER BY event_date ASC ) as earliest_date
FROM Activity)

SELECT 
        player_id,
       event_date

FROM ranked_dates
WHERE earliest_date = 1
