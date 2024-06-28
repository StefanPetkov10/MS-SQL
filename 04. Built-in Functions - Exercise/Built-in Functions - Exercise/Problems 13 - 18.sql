--Problem 13
SELECT [p].[PeakName],
       [r].[RiverName],
	  LOWER(CONCAT(SUBSTRING([p].[PeakName], 1, LEN([p].[PeakName]) - 1), [r].[RiverName]))
	AS [Mix]   
  FROM [Peaks]
    AS [p],
	   [Rivers]
	AS [r]
 WHERE RIGHT(LOWER([p].[PeakName]), 1) = LEFT(LOWER([r].[RiverName]), 1)
ORDER BY [Mix]

GO

--Problem 14
USE [Diablo]

GO

SELECT TOP(50) [Name],
		FORMAT([Start], 'yyyy-MM-dd')
		AS [Start]
      FROM [Games]
	 WHERE YEAR([Start]) IN (2011, 2012)
  ORDER BY [Start],
		   [Name]

--Problem 15
 SELECT [Username],
	    SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email]) - CHARINDEX('@', [Email]))
	  AS [Email Provider]
    FROM [Users]
ORDER BY [Email Provider],
		 [Username]

--Problem 16
SELECT [Username],
	   [IpAddress]
  FROM [Users]
 WHERE [IpAddress] LIKE '___.1_%._%.___'
 ORDER BY [Username]

--Problem 17
  SELECT [Name]
      AS [Game],
	     CASE 
		    WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
			ELSE 'Evening'
		 END
			AS [Part of the Day],
		 CASE 
		    WHEN [Duration] <= 3 THEN 'Extra Short'
			WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
			WHEN [Duration] > 6 THEN 'Long'
			ELSE 'Extra Long'
		 END
		    AS [Duratin]
    FROM [Games]
ORDER BY [Game],
         [Duratin],
		 [Part of the Day]
		 
--[d].[Duration] for the initial column
--[Duratin] for new Alias	

GO
--Problem 18
USE [Orders]
GO

SELECT [ProductName],
	   [OrderDate],
	   DATEADD(DAY, 3, [OrderDate]) AS [Pay Due],
	   DATEADD(MONTH, 1, [OrderDate]) AS [Deliver Due]
  FROM [Orders]
