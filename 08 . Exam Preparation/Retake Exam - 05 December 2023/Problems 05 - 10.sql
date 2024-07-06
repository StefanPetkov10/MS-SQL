-- 05. Tickets by Price and Date Departure
  SELECT DateOfDeparture,
		 Price
	  AS TicketPrice
    FROM Tickets
ORDER BY Price,
		 DateOfDeparture DESC

-- 06. Passengers with their Tickets 
    SELECT p.[Name]
		AS PassengerName,
		   t.Price
		AS TicketPrice,
		   DateOfDeparture,
		   t.TrainId
	  FROM Tickets
	    AS t
INNER JOIN [Passengers]
		AS p
		ON t.PassengerId = p.Id
  ORDER BY t.Price DESC,
		   p.[Name]

-- 07. Railway Stations without Passing Trains
	  SELECT t.[Name],
			 rs.[Name]
		  AS RailwayStation
	    FROM Towns
		  AS t
  INNER JOIN RailwayStations
		  AS rs
		  ON t.Id = rs.TownId
   LEFT JOIN TrainsRailwayStations
		  AS trs
		  ON trs.RailwayStationId = rs.Id
	   WHERE trs.RailwayStationId IS NULL
	ORDER BY t.[Name],
			 rs.[Name]

-- 08. First 3 Trains Between 08:00 and 08:59
	SELECT 
   TOP (3) t.Id,
		   t.HourOfDeparture,
		   tic.Price
		AS TicketsPrice,
		   town.[Name]
		AS Destination
	  FROM Trains
	    AS t
INNER JOIN Tickets
		AS tic
		ON t.Id = tic.TrainId
INNER JOIN Towns
		AS town
		ON t.ArrivalTownId = town.Id
	 WHERE t.HourOfDeparture LIKE '08:%' AND
		   tic.Price > 50
  ORDER BY tic.Price 

-- 09. Count of Passengers Paid More Than Average
	SELECT Tw.[Name], 
		   COUNT(Ti.Id)
		AS PassengersCount
	  FROM Tickets AS Ti
INNER JOIN Trains 
		AS Tr 
		ON Tr.Id = Ti.TrainId
INNER JOIN Towns 
		AS Tw 
		ON Tw.Id = Tr.ArrivalTownId
	 WHERE Ti.Price > 76.99
  GROUP BY Tw.[Name]
  ORDER BY Tw.[Name]

-- 10. Maintenance Inspection with Town and Station
   SELECT tr.Id
	   AS TrainId,
		  t.[Name]
	   AS DepartureTown,
	      mr.Details
     FROM Towns
       AS t
LEFT JOIN Trains
	   AS tr
	   ON t.Id = tr.DepartureTownId
LEFT JOIN MaintenanceRecords
	   AS mr
	   ON mr.TrainId = tr.Id
    WHERE mr.Details LIKE '%inspection%'
 ORDER BY tr.Id