-- Problem 02
Select * FROM Departments

-- Problem 03
SELECT Name FROM Departments

-- Problem 05
SELECT FirstName, LastName, Salary FROM Employees

-- Problem 05
SELECT FirstName, MiddleName, LastName FROM Employees

--Problem 06
SELECT CONCAT([FirstName], '.', [LastName], '@', 'softuni.bg')
	AS [Full email adress]
  FROM Employees

--Problem 06 with operator
SELECT [FirstName] + '.' + [MiddleName] + '.' + [LastName] + '@' + 'softuni.bg'
	AS [Full email adress]
  FROM Employees

--Problem 06 with removing
SELECT CONCAT([FirstName], '.', [MiddleName] + '.', [LastName], '@', 'softuni.bg')
	AS [Full email adress]
  FROM Employees

--Problem 07
SELECT DISTINCT Salary
		   FROM Employees

-- Problem 08
SELECT * FROM Employees
 WHERE JobTitle = 'Sales Representative'