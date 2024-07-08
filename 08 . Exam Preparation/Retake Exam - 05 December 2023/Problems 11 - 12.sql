-- 11. Towns with Trains
CREATE FUNCTION udf_TownsWithTrains(@name VARCHAR(30)) 
	RETURNS INT
			 AS
		  BEGIN
				 DECLARE @townsId INT;
					SET @townsId = ( SELECT Id
									 FROM Towns
									WHERE [Name] = @name
									);

				 DECLARE @townsWithTrainsCount INT;
					SET @townsWithTrainsCount = ( SELECT COUNT(*)
													FROM Trains
												   WHERE DepartureTownId = @townsId OR ArrivalTownId = @townsId
												);
				RETURN @townsWithTrainsCount
		    END

SELECT dbo.udf_TownsWithTrains('Paris') AS [Output]

-- 12. Search Passengers travelling to Specific Town
CREATE PROCEDURE usp_SearchByTown @townName VARCHAR(30)
			  AS
		   BEGIN
					 SELECT p.[Name]
					     AS PassengerName,
						    tic.DateOfDeparture,
							t.HourOfDeparture
					   FROM Trains
					     AS t
				 INNER JOIN Tickets
						 AS tic
						 ON t.Id = tic.TrainId
				 INNER JOIN Passengers
						 AS p
						 ON p.Id = tic.PassengerId
				 INNER JOIN Towns
						 AS town
						 ON town.Id = t.ArrivalTownId
					  WHERE town.[Name] = @townName
				   ORDER BY tic.DateOfDeparture DESC,
							p.[Name]
		     END