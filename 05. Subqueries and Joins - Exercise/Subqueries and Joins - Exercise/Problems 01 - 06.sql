USE [SoftUni]

GO

--Problem 01
   SELECT 
  TOP (5) [e].EmployeeID,
		  [e].JobTitle,
		  [e].AddressID,
		  [a].AddressText
     FROM [Employees]
       AS [e]
LEFT JOIN  [Addresses] 
       AS [a]
	   ON [e].AddressID = [a].AddressID
 ORDER BY [e].AddressID

 --Problem 02
   SELECT 
   TOP (50)
		  [e].FirstName,
		  [e].LastName,
		  [t].[Name],
		  [a].AddressText
     FROM [Employees]
       AS [e]
LEFT JOIN [Addresses] 
       AS [a]
	   ON [e].AddressID = [a].AddressID
LEFT JOIN [Towns]
       AS [t]
	   ON [a].TownID = [t].TownID
 ORDER BY [e].FirstName,
          [e].LastName
			

 --Problem 03
   SELECT [e].EmployeeID,
		  [e].FirstName,
		  [e].LastName,
		  [d].[Name]
	   AS DepartmentName
     FROM [Employees]
	   AS [e]
LEFT JOIN [Departments] 
       AS [d]
	   ON [e].DepartmentID = [d].DepartmentID
	WHERE [d].[Name] = 'Sales'
 ORDER BY [e].EmployeeID 

 --Problem 04
   SELECT 
   TOP (5)
	      [e].EmployeeID,
		  [e].FirstName,
		  [e].Salary,
		  [d].[Name]
	   AS DepartmentName
     FROM [Employees]
	   AS [e]
LEFT JOIN [Departments] 
       AS [d]
	   ON [e].DepartmentID = [d].DepartmentID
	WHERE [d].[Name] = 'Engineering' AND [e].Salary > 15000
 ORDER BY [e].DepartmentID

  --Problem 05
   SELECT 
   TOP (3)
		  [e].EmployeeID,
		  [e].FirstName
     FROM Employees
	   AS [e]
LEFT JOIN [EmployeesProjects] 
	   AS [ep]
	   ON [e].EmployeeID = [ep].EmployeeID
	WHERE [ep].EmployeeID IS NULL
 ORDER BY [e].EmployeeID

 --Problem 06
  SELECT 
		  [e].FirstName,
		  [e].LastName,
		  [e].HireDate,
		  [d].[Name]
	   AS DeptName
     FROM [Employees]
	   AS [e]
LEFT JOIN [Departments] 
       AS [d]
	   ON [e].DepartmentID = [d].DepartmentID
	WHERE ([d].[Name] = 'Finance' OR [d].[Name] = 'Sales') AND [e].HireDate > '1999.1.1'
 ORDER BY [e].HireDate