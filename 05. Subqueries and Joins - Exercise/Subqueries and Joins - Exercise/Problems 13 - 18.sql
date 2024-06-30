USE [Geography]

GO

--Problem 13
   SELECT [CountryCode],
   	      COUNT(MountainId)
       AS [MountainRanges]	
     FROM [MountainsCountries]
    WHERE [CountryCode] IN (
                            SELECT [CountryCode]
						      FROM [Countries]
						     WHERE [CountryName] IN ('UNITED States', 'Russia', 'Bulgaria')
 )
 GROUP BY [CountryCode]

 --Problem 14
   SELECT 
   TOP (5)  
		  [countr].CountryName,
		  [r].RiverName
     FROM [Continents]
       AS [c]
LEFT JOIN [Countries]
	   AS [countr]
	   ON [c].ContinentCode = [countr].ContinentCode
LEFT JOIN [CountriesRivers]
       AS [cr]
	   ON [cr].CountryCode = [countr].CountryCode
LEFT JOIN [Rivers]
	   AS [r]
	   ON [r].Id = [cr].RiverId
	WHERE [c].ContinentName = 'Africa'
 ORDER BY [countr].CountryName ASC


 --Problem 15
SELECT [ContinentCode],
	   [CurrencyCode],
	   [CurrencyUsage]
  FROM (
		SELECT *,
		DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC)
		AS [CurrencyRank]
		FROM (
			  SELECT [ContinentCode],
					 [CurrencyCode],
			         COUNT(*)
			      AS [CurrencyUsage]
				FROM [Countries]
		    GROUP BY [ContinentCode], [CurrencyCode]
		      HAVING COUNT(*) > 1
			 )
				  AS [CurrencyUsageSubquery]
)
    AS [CurrencyRankingSubquery]
 WHERE [CurrencyRank] = 1

 --Problem 16
   SELECT COUNT(*)
	   AS [Count]
     FROM [Countries]
	   AS [c]
LEFT JOIN [MountainsCountries]
	   AS [mc]
	   ON [c].CountryCode = [mc].CountryCode
LEFT JOIN [Mountains]
	   AS [m]
	   ON [m].Id = [mc].MountainId
	WHERE [m].Id IS NULL

--Problem 17
  SELECT 
  TOP (5)
	     CountryName,
	     MAX(Elevation) 
	  AS HighestPeakElevation,
	     MAX(r.[Length]) 
	  AS LongestRiverLength
	FROM Countries 
AS c
LEFT JOIN CountriesRivers
       AS cr 
	   ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers 
	   AS r 
	   ON r.Id = cr.RiverId 
LEFT JOIN MountainsCountries 
	   AS mc 
	   ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains 
       AS m 
	   ON m.Id = mc.MountainId
LEFT JOIN Peaks
	   AS p 
	   ON p.MountainId = m.Id
GROUP BY 
	CountryName
ORDER BY
	HighestPeakElevation DESC,
	LongestRiverLength DESC,
	CountryName

--Problem 18
---Method 1.1
 SELECT
TOP (5)
		CountryName
	 AS [Country],
	    ISNULL([PeakName], '(no highest peak)')
	 AS [Highest Peak Name],
	 ---Method1
	    ISNULL([Elevation], '0')
	 AS [Highest Peak Elevation],
	 ---Method2
     CASE 
        WHEN [MountainRange] IS NULL
        THEN '(no mountain)'
     ELSE [MountainRange]
     END
	 AS [Mountain]
  FROM (
	    SELECT [c].CountryName,
			  [p].PeakName,
			  [p].Elevation,
			  [m].MountainRange,
			  DENSE_RANK() OVER(PARTITION BY [c].[CountryName]  ORDER BY [p].[Elevation] DESC)
		   AS [PeakRank]
		 FROM [Countries]
	       AS [c]
	LEFT JOIN [MountainsCountries]
		   AS [mc]
		   ON [mc].CountryCode = [c].CountryCode
	LEFT JOIN [Mountains]
		   AS [m]
		   ON [mc].MountainId = [m].Id
	LEFT JOIN [Peaks]
		   AS [p]
		   ON [p].MountainId = [m].Id
)
    AS [PeakRankingSubquery]
 WHERE [PeakRank] = 1
ORDER BY [Country],
		 [Highest Peak Name]

---Method 1.2
WITH PeaksRankedByElevation AS 
(
	SELECT
		c.CountryName,
		p.PeakName,
		p.Elevation,
		m.MountainRange,
		DENSE_RANK() OVER
			(PARTITION BY c.CountryName ORDER BY Elevation DESC) AS PeakRank
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p ON m.Id = p.MountainId
)

SELECT TOP(5)
	CountryName AS Country,
	ISNULL(PeakName, '(no highest peak)') AS [Highest Peak Name],
	ISNULL(Elevation, 0) AS [Highest Peak Elevation],
	ISNULL(MountainRange, '(no mountain)') AS Mountain
FROM PeaksRankedByElevation
WHERE PeakRank = 1
ORDER BY 
	CountryName, [Highest Peak Name]