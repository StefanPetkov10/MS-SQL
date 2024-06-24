--Problem 09
SELECT FirstName, LastName, JobTitle
  FROM Employees
 WHERE Salary BETWEEN 20000 AND 30000 --INCLUSIVE

 --Problem 09
SELECT FirstName, LastName, JobTitle
  FROM Employees
 WHERE Salary >= 20000 AND Salary <= 30000 --Between is better

 --Problem 10
 SELECT CONCAT (FirstName + ' ', MiddleName + ' ', LastName)--CONCAT_WS(' ', FirstName, ...)
	AS [Full Name]
  FROM [Employees]
 WHERE [Salary] IN (25000, 14000, 12500, 23600)

--Problem 11
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [ManagerID] IS NULL

 --Pronlem 12

 SELECT [FirstName],
		[LastName],
		[Salary]
   FROM [Employees]
  WHERE [Salary] > 50000
  ORDER BY [Salary] DESC

--Problem 13
  SELECT 
 TOP(5)  [FirstName],
		 [LastName] 
	FROM [Employees]
ORDER BY [Salary] DESC

--Problem 14
SELECT [FirstName]
	  ,[LastName]
  FROM [Employees]
 WHERE [DepartmentID] NOT IN(4)
