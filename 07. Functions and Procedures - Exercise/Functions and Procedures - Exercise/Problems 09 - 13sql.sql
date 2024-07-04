USE [Bank]

GO

-- Problem 09
CREATE PROCEDURE [usp_GetHoldersFullName] 
			  AS
		   BEGIN
					SELECT CONCAT(FirstName + ' ', LastName)
					    AS [Full Name]
					  FROM[AccountHolders]
		     END

-- Problem 10
CREATE PROCEDURE [usp_GetHoldersWithBalanceHigherThan] @balance DECIMAL (18, 4)
			 AS
		 SELECT 
				[FirstName],
				[LastName]
		   FROM AccountHolders 
		     AS [ah]
	 INNER JOIN Accounts 
	         AS [a] ON [ah].Id = [a].AccountHolderId
       GROUP BY [ah].Id,
				[FirstName], 
				[LastName]
         HAVING SUM([a].Balance) > @balance
       ORDER BY FirstName, LastName

--Problem 11 
CREATE FUNCTION [ufn_CalculateFutureValue] (
											@initialSum DECIMAL(18, 4),
											@yearlyInterestRate FLOAT,
											@numberOfYears INT
										   )
RETURNS DECIMAL(18, 4) 
			 AS
		  BEGIN
					DECLARE @futureValue DECIMAL(18, 4);

					--FV = I × (1 + R)^T
					SET @futureValue = @initialSum * POWER((1 + @yearlyInterestRate), @numberOfYears);
					SET @futureValue = ROUND(@futureValue, 4);

					RETURN @futureValue
		    END	

SELECT [dbo].[ufn_CalculateFutureValue] (1000, 0.1, 5)


-- Problem 12
CREATE PROCEDURE [usp_CalculateFutureValueForAccount] @AccountId INT,
													  @interestRate FLOAT
			  AS
		   BEGIN
					DECLARE @FirstName NVARCHAR(50)
					DECLARE @LastName NVARCHAR(50)
					DECLARE @CurrentBalance DECIMAL(18, 4)

					SELECT @FirstName = FirstName,
						   @LastName = LastName,
						   @CurrentBalance = Balance
					  FROM AccountHolders ah
				INNER JOIN Accounts a ON ah.Id = a.AccountHolderId
					 WHERE a.Id = @AccountId

				    DECLARE @FutureValue DECIMAL(18, 4)
						SET @FutureValue = dbo.ufn_CalculateFutureValue(@CurrentBalance, @interestRate, 5)

					SELECT  @AccountId AS AccountId,
							@FirstName AS FirstName,
							@LastName AS LastName,
							@CurrentBalance AS CurrentBalance,
							@FutureValue AS FutureBalance
				END

EXEC [dbo].[usp_CalculateFutureValueForAccount] 1, 
												0.1

--Problem 13
USE [Diablo]

GO

CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(100))
RETURNS TABLE
AS
RETURN
   (
    SELECT SUM(Cash) AS SumCash
    FROM (
          SELECT Cash, ROW_NUMBER() OVER (ORDER BY Cash DESC) AS RowNum
            FROM Games AS g
		    JOIN UsersGames AS ug ON ug.GameId = g.Id
           WHERE g.[Name] = @gameName
    ) AS RankedData
    WHERE RowNum % 2 <> 0
)