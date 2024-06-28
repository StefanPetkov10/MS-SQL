USE [SoftUni]

--Problem 01
---Method 1
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE LEFT([FirstName], 2) = 'Sa'

 ---Method 2
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [FirstName] LIKE 'Sa%'

 --Problem 02
 ---Method 1
 SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE CHARINDEX('ei', [LastName]) > 0 

 ---Method 2
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [LastName] LIKE '%ei%'

 --Problem 03
 SELECT [FirstName]  
  FROM [Employees]
 WHERE [DepartmentID] IN(3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005

 --Problem 04
  ---Method 1
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE CHARINDEX('engineer', [JobTitle]) = 0

  ---Method 2
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [JobTitle] NOT LIKE '%engineer%'

 --Problem 05
  SELECT [Name]
    FROM [Towns]
   WHERE LEN([Name]) IN (5, 6)
ORDER BY [NAME] 

 --Problem 06
---Method 1
  SELECT *
    FROM [Towns]
   WHERE LEFT([NAME], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

---Method 2
 SELECT *
    FROM [Towns]
   WHERE [NAME] LIKE '[MKBE]%'
ORDER BY [Name]
