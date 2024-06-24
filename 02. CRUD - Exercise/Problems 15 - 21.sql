--Problem 15
SELECT *
  FROM [Employees]
ORDER BY [Salary] DESC,
		 [FirstName],
		 [LastName] DESC,
		 [MiddleName]

--Problem 16
CREATE VIEW [V_EmployeesSalaries] 
		 AS(
     SELECT FirstName, LastName, Salary
       FROM Employees)

SELECT * FROM [V_EmployeesSalaries]

--Problem 17
CREATE VIEW [V_EmployeeNameJobTitle] 
		 AS(
     SELECT CONCAT([FirstName], ' ', [MiddleName], ' ', [LastName])
	 --SELECT [FirstName] + ' ' + ISNULL([MiddleName], '') + ' ' + [LastName]
		 AS [Full Name],
			[JobTitle]
       FROM Employees)

SELECT * FROM [V_EmployeeNameJobTitle]

--Problem 18
SELECT DISTINCT [JobTitle] FROM [Employees];

--Problem 19
  SELECT 
  TOP (10) * --, FORMAT([StartDate], 'yyyy-MM-dd') AS [Date]
    FROM [Projects]
ORDER BY [StartDate],
		 [Name]

--Pronlem 20
  SELECT 
  TOP (7) 
		 [FirstName]
		,[LastName]
		,[HireDate]
    FROM [Employees]
ORDER BY HireDate DESC
		
--Problem 21
SELECT [DepartmentID]
  FROM [Departments]
 WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services') --To see ID

 UPDATE [Employees]
    SET [Salary] += 0.12 * [Salary]
  WHERE [DepartmentID] IN (1, 2, 4, 11)

 SELECT [Salary]
   FROM [Employees]

   --Advanced

 UPDATE [Employees]
    SET [Salary] += 0.12 * [Salary]
  WHERE [DepartmentID] IN 
  (
 SELECT [DepartmentID]
   FROM [Departments]
  WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services') 
  )