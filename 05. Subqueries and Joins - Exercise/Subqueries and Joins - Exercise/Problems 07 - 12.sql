-- Problem 07
    SELECT 
   TOP (5) [e].EmployeeID,
		   [e].FirstName,
		   [p].[Name]
		AS ProjectName
      FROM EmployeesProjects
	    AS [ep]
INNER JOIN [Employees]
		AS [e]
		ON [ep].EmployeeID = [e].EmployeeID
INNER JOIN Projects
		AS [p]
		ON [ep].ProjectID = [p].ProjectID
	 WHERE [p].StartDate > '2002.08.13' AND [p].EndDate IS NULL
  ORDER BY [e].EmployeeID

--Problem 09
   SELECT 
		   [e].EmployeeID,
		   [e].FirstName,
		CASE 
        WHEN StartDate >= '2005-01-01' THEN NULL
        ELSE [p].[Name]
    END AS ProjectName
      FROM EmployeesProjects
	    AS [ep]
INNER JOIN [Employees]
		AS [e]
		ON [ep].EmployeeID = [e].EmployeeID
INNER JOIN Projects
		AS [p]
		ON [ep].ProjectID = [p].ProjectID
	 WHERE [e].EmployeeID = 24

--Problem 09
    SELECT [e].EmployeeID,
		   [e].FirstName,
		   [e].ManagerID,
		   [m].FirstName
		AS [ManagerName]
	  FROM [Employees]
	    AS [e]
INNER JOIN [Employees]
		AS [m]
		ON [e].ManagerID = [m].EmployeeID
	 WHERE [e].ManagerID IN (3, 7)
  ORDER BY [e].EmployeeID

--Problem 10
	SELECT 
   TOP (50)
           [e].EmployeeID,
	CONCAT([e].FirstName + ' ', [e].LastName)
		AS [EmployeeName],
	CONCAT([m].FirstName + ' ', [m].LastName)
		AS [ManagerName],
		   [d].[Name]
		AS [DepatmentName]
      FROM [Employees]
	    AS [e]
INNER JOIN [Departments]
		AS [d]
		ON [e].DepartmentID = [d].DepartmentID
INNER JOIN [Employees]
		AS [m]
		ON [e].ManagerID = [m].EmployeeID
  ORDER BY [e].EmployeeID

--Problem 11

---Method 1
SELECT 
   MIN(dt.AvgSalary) 
   AS MinAverageSalary
  FROM 
     (SELECT
	     AVG(Salary) AS AvgSalary
	    FROM Employees
    GROUP BY DepartmentID)
   AS dt

---Method 2
SELECT 
 TOP 1 *
  FROM 
     (SELECT
	     AVG(Salary) AS AvgSalary
	    FROM Employees
    GROUP BY DepartmentID)
   AS dt
ORDER BY dt.AvgSalary


GO

USE [Geography]

GO

--Pronlem 12
    SELECT [mc].CountryCode,
		   [m].MountainRange,
		   [p].PeakName,
		   [p].Elevation
	  FROM [MountainsCountries]
	    AS [mc]
INNER JOIN [Countries]
		AS [c]
		ON [mc].CountryCode = [c].CountryCode
INNER JOIN [Mountains]
		AS [m]
		ON [m].Id = [mc].MountainId
INNER JOIN [Peaks]
		AS [p]
		ON [p].MountainId = [m].Id
	 WHERE [c].CountryName = 'Bulgaria' AND
	       [p].Elevation > 2835
  ORDER BY [p].Elevation DESC