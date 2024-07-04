USE SoftUni

GO
--Problem 01
CREATE PROCEDURE [usp_GetEmployeesSalaryAbove35000]
------OR ALTER PROCEDURE 
			  AS 
		   BEGIN
				 SELECT [FirstName],
						[LastName]
				   FROM [Employees]
				  WHERE [Salary] > 35000
			 END

EXEC [dbo].[usp_GetEmployeesSalaryAbove35000]
-----[dbo] is the default schema in SQL Server.


--Problem 02
CREATE PROCEDURE [usp_GetEmployeesSalaryAboveNumber] @minSalary DECIMAL(18, 4)
			  AS 
		   BEGIN
				 SELECT [FirstName],
						[LastName]
				   FROM [Employees]
				  WHERE [Salary] >= @minSalary
			 END

EXEC [dbo].[usp_GetEmployeesSalaryAboveNumber] 48100


--Problem 03
---Method 1
CREATE PROCEDURE [usp_GetTownsStartingWith] @letter NVARCHAR(10)
			  AS
		   BEGIN 
				 SELECT [Name]
				     AS [Town]
				   FROM [Towns]
				  WHERE LEFT(LOWER([Name]), LEN(@letter)) = @letter
			 END

EXEC [dbo].[usp_GetTownsStartingWith] 'b'

---Method 2
CREATE PROCEDURE [usp_GetTownsStartingWith2] @letter NVARCHAR(10)
			  AS
		   BEGIN 
				 SELECT [Name]
				     AS [Town]
				   FROM [Towns]
				  WHERE [Name] LIKE '@letter%'
			 END

EXEC [dbo].[usp_GetTownsStartingWith] 'b'

--Problem 04
CREATE PROCEDURE [usp_GetEmployeesFromTown] @nameTown NVARCHAR(50)
			  AS
		   BEGIN 
				     SELECT [FirstName]
						   ,[LastName]
				       FROM [Employees]
				         AS [e]
				 INNER JOIN [Addresses]
						 AS [a]
						 ON [e].AddressID = [a].AddressID
				  INNER JOIN [Towns]
						 AS [t]
						 ON [t].TownID = [a].TownID
				  WHERE [t].[Name] = @nameTown
			 END

EXEC [dbo].[usp_GetEmployeesFromTown] 'Sofia'

--Pronlem 05
CREATE FUNCTION [ufn_GetSalaryLevel](@salary DECIMAL(18,4)) 
RETURNS VARCHAR(8)
			 AS
		  BEGIN
		        DECLARE @salaryLevel VARCHAR(8)

				     IF @salary < 30000
				  BEGIN
				    SET @salaryLevel = 'Low'
					END
				ELSE IF @salary BETWEEN 30000 AND 50000
				  BEGIN
				    SET @salaryLevel = 'Average'
					END
				ELSE IF @salary > 50000
				  BEGIN
				    SET @salaryLevel = 'High'
					END

				 RETURN @salaryLevel
			END

SELECT [FirstName]
	  ,[LastName]
	  ,[dbo].[ufn_GetSalaryLevel](50001)
    AS ReturnSalary
  FROM [SoftUni].[dbo].[Employees]

  SELECT [FirstName]
	  ,[LastName]
	  ,[dbo].[ufn_GetSalaryLevel]([Salary])
    AS ReturnSalary
  FROM [SoftUni].[dbo].[Employees]


--Problem 06
CREATE PROCEDURE [usp_EmployeesBySalaryLevel] @salaryLevel VARCHAR(8)
			  AS
		   BEGIN
		         SELECT [FirstName],
						[LastName]
				   FROM [Employees]
				  WHERE [dbo].[ufn_GetSalaryLevel]([Salary]) = @salaryLevel
			 END

EXEC [dbo].[usp_EmployeesBySalaryLevel] 'High'
EXEC [dbo].[usp_EmployeesBySalaryLevel] 'Average'
EXEC [dbo].[usp_EmployeesBySalaryLevel] 'Low'

--Problem 07
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
	RETURNS BIT
			 AS
		  BEGIN
					DECLARE @wordIndex INT = 1;
					WHILE(LEN(@word) >= @wordIndex)
					BEGIN

					DECLARE @currentChar CHAR = SUBSTRING(@word, @wordIndex, 1);

					IF CHARINDEX(@currentChar, @setOfLetters) = 0
					BEGIN
					RETURN 0
					END

					SET @wordIndex += 1;
					END

					RETURN 1
			END

SELECT[dbo].ufn_IsWordComprised('oistmiahf', 'Sofia')

--Problem 08
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
			  AS
		   BEGIN
				 -- We need to store all Id's of the Employees that are going to removed
				 DECLARE @employeesToDelete TABLE([Id] INT);
				 INSERT INTO @employeesToDelete
							 SELECT [EmployeeID]
							   FROM [Employees]
							  WHERE [DepartmentID] = @departmentId

				 -- Employees which we are going to remove can working on same
				 -- projects. So we need to remove them from working on this projects.
				 DELETE
				   FROM [EmployeesProjects]
				  WHERE [EmployeeID] IN (SELECT * FROM @employeesToDelete)

				 -- Employees which we are going to remove can be Managers of same Departments
				 -- So we need to set ManagerId to NULL of all Departments with futurely delete ManagerId
				 -- First we need to alter column ManagerId
				 ALTER TABLE [Departments]
				 ALTER COLUMN [ManagerId] INT

				 UPDATE [Departments]
				    SET [ManagerID] = NULL
				  WHERE [ManagerID] IN (SELECT * FROM @employeesToDelete)

				  -- Employees which we are going to remove can be Managers of another Employees
				  --So we need to set ManagerId to NULL of all Employees with futurely delete ManagerId
				  UPDATE [Employees]
				    SET [ManagerID] = NULL
				  WHERE [ManagerID] IN (SELECT * FROM @employeesToDelete)

				  -- Since we remove all references to tha employees we want to remove 
				  -- We ca safely remove them 
				  DELETE
				    FROM [Employees]
				   WHERE [DepartmentID] = @departmentId

				  DELETE
				    FROM [Departments]
				   WHERE [DepartmentID] = @departmentId

				   SELECT COUNT(*)
				     FROM [Employees]
					WHERE [DepartmentID] = @departmentId
		     END

EXEC [dbo].[usp_DeleteEmployeesFromDepartment] 7

