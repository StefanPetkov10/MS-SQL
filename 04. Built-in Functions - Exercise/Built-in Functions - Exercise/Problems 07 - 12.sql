--Problem 07
---Method 1
  SELECT *
    FROM [Towns]
   WHERE LEFT([NAME], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name]

---Method 2
 SELECT *
    FROM [Towns]
   WHERE [NAME] NOT LIKE '[RBD]%'
ORDER BY [Name]

--Problem 08
CREATE VIEW [V_EmployeesHiredAfter2000] 
		 AS(
	 SELECT [FirstName],
			[LastName]
	   FROM [Employees]
	  WHERE YEAR([HireDate]) > 2000)

--Problem 09
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE LEN([LastName]) = 5

 --Problem 10
  SELECT [EmployeeID],
         [FirstName],
		 [LastName],
		 [Salary],
         DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
	  AS [Rank]
    FROM [Employees]
   WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC

--Problem 11
SELECT *
  FROM (
		 SELECT [EmployeeID],
         [FirstName],
		 [LastName],
		 [Salary],
         DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
	  AS [Rank]
    FROM [Employees]
   WHERE [Salary] BETWEEN 10000 AND 50000
		) AS [RankingSubQuery]
 WHERE [Rank] = 2
 ORDER BY [Salary] DESC

 --Problem 12
 USE [Geography]

 GO
 ---Method 1
   SELECT [CountryName]
   	   AS [Country Name],
   	      [IsoCode]
   	   AS [ISO Code]
     FROM [Countries]
	WHERE LOWER([CountryName]) LIKE '%a%a%a%'
ORDER  BY [ISO Code]

---Method 2
   SELECT [CountryName]
   	   AS [Country Name],
   	      [IsoCode]
   	   AS [ISO Code]
     FROM [Countries]
	WHERE LEN([CountryName]) - LEN(REPLACE(LOWER([CountryName]), 'a', '')) >=3
ORDER  BY [ISO Code]