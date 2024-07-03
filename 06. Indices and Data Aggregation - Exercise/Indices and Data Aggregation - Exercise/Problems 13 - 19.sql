USE [SoftUni]

GO
--Problem13
  SELECT [DepartmentID],
	     SUM(Salary)
	  AS ToatalSalary
    FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID]

--Problem 14
 SELECT [DepartmentID],
	     MIN(Salary)
	  AS MinimumSalary
    FROM [Employees]
   WHERE [HireDate] > 01/01/2000 
GROUP BY [DepartmentID]
  HAVING [DepartmentID] IN (2, 5, 7)
ORDER BY [DepartmentID]

--Problem 15
---My Method
  SELECT [DepartmentID],
		 AVG([NewSalary])
	  AS AverageSalary
    FROM 
       (
	    SELECT 
		       [DepartmentID],
		  CASE
		      WHEN [DepartmentID] = 1 THEN [Salary] + 5000
			  ELSE [Salary]
		   END
		    AS [NewSalary]
		  FROM [Employees]
		 WHERE [Salary] > 30000 AND [DepartmentID] NOT IN (42)
	   )AS [Table]
GROUP BY DepartmentID
  
---For Judge
SELECT * 
  INTO RichEmployees
  FROM Employees
 WHERE Salary > 30000

DELETE 
  FROM RichEmployees
 WHERE ManagerID = 42

UPDATE RichEmployees
   SET Salary = Salary + 5000
 WHERE DepartmentID = 1

  SELECT DepartmentID, 
         AVG(Salary)
	  AS AverageSalary
    FROM RichEmployees
GROUP BY DepartmentID

--Problem 16
  SELECT [DepartmentID],
		 MAX(Salary)
	  AS [MaxSalary]
    FROM 
	     (
		  SELECT *
			FROM [Employees]
		   WHERE [Salary] NOT BETWEEN 30000 AND 70000
		 ) AS[MaxSalaries]
GROUP BY [DepartmentID]

  SELECT [DepartmentID],
		 MAX(Salary)
	  AS [MaxSalary]
    FROM Employees
GROUP BY [DepartmentID]
  HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--Problem 17
SELECT COUNT(*)
    AS [Count]
  FROM [Employees]
 WHERE [ManagerID] IS NULL

--Problem 18
  SELECT 
DISTINCT [DepartmentID],
	     [Salary]
	  AS [ThirdHighestSalary]
    FROM 
	     (
	      SELECT [DepartmentID],
		   	     [Salary],
		   	     DENSE_RANK() OVER (PARTITION BY [DepartmentId] ORDER BY [Salary] DESC)
		       AS [SalaryRank]
		     FROM [Employees]
	     ) 
	  AS [SalaryRankingSubquery]
   WHERE [SalaryRank] = 3

--Problem 19
  SELECT
TOP (10) [e].FirstName,
		 [e].LastName,
		 [e].DepartmentID
    FROM [Employees]
	  AS [e]
   WHERE [e].Salary > 
        (
		      SELECT AVG([Salary])
			      AS [AverageSalary]
			    FROM [Employees]
			      AS [eSub]
			   WHERE [eSub].DepartmentID = [e].DepartmentID
			GROUP BY [DepartmentID]
		 )
ORDER BY [e].DepartmentID