USE [Gringotts]

--Problem 01
SELECT COUNT(Id)
	AS [Count]
  FROM [WizzardDeposits]

--Problem 02
SELECT MAX(MagicWandSize)
	AS LongestMagicWand
  FROM [WizzardDeposits]

--Problem 03
  SELECT [DepositGroup],
		 MAX([MagicWandSize])
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Problem 04
  SELECT [DepositGroup],
		 AVG([MagicWandSize])
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

 SELECT 
 TOP (2) [DepositGroup]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]
ORDER BY AVG([MagicWandSize])

--Problem 05
  SELECT [DepositGroup],
		 SUM([DepositAmount])
	  AS TotalSum
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Problem 06
  SELECT [DepositGroup],
  		 SUM([DepositAmount])
	  AS TotalSum
    FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
  HAVING [MagicWandCreator] = 'Ollivander family'

--Problem 07
  SELECT [DepositGroup],
  		 SUM([DepositAmount])
	  AS TotalSum
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
  HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC

