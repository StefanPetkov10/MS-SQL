--Problem 08
  SELECT [DepositGroup],
		 [MagicWandCreator],
  		 MIN([DepositCharge])
	  AS MinDepositCharge
    FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator],
		 [DepositGroup]

--Problem 09
  SELECT [AgeGroup],
		 COUNT(*)
    FROM (
		  SELECT 
		  CASE
		  	  WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
		  	  WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
		  	  WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
		  	  WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
		  	  WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
		  	  WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
		  	  ELSE '[61+]'
		   END
	AS [AgeGroup]
  FROM [WizzardDeposits]
)
      AS [AgeGroupSubquery]
GROUP BY [AgeGroup]


--Problem 10
  SELECT LEFT(FirstName, 1)
	  AS FirstLetter
    FROM [WizzardDeposits]
   WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)
ORDER BY FirstLetter

--Problem 11
  SELECT [DepositGroup],
		 [IsDepositExpired],
		 AVG([DepositInterest])
	  AS [AverageInterest]
    FROM [WizzardDeposits]
   WHERE [DepositStartDate] > '01/01/1985'
GROUP BY [DepositGroup], [IsDepositExpired]
ORDER BY [DepositGroup] DESC,
		 [IsDepositExpired]

--Problem 12
---Method 1
    SELECT *
      FROM [WizzardDeposits]
	    AS [wd1]
INNER JOIN [WizzardDeposits]
		AS [wd2]
		ON [wd1].Id = [wd2].Id + 1--....

---Method 2
SELECT
       SUM([Difference])
  FROM
  (
    SELECT [FirstName]
	    AS [Host Wizard],
	       [DepositAmount]
	    AS [Host Wizard Deposit],
	       LEAD([FirstName]) OVER(ORDER BY [Id])
	    AS [Guest Wizard],
	       LEAD([DepositAmount]) OVER(ORDER BY [Id])
	    AS [Guest Wizard Deposit],
	       [DepositAmount] - LEAD([DepositAmount]) OVER(ORDER BY [Id])
	    AS [Difference]
      FROM [WizzardDeposits]
  )AS [SumDifference]