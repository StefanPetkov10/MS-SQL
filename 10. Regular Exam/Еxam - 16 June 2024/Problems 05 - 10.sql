-- 05. Chronological Order
  SELECT Title
	  AS 'Book Title',
		 ISBN,
		 YearPublished
	  AS 'YearReleased'
    FROM Books
ORDER BY YearPublished DESC,
	     Title

-- 06. Books by Genre
   SELECT b.Id,
		  b.Title,
		  b.ISBN,
		  g.[Name]
     FROM Books
       AS b
     JOIN [Genres]
       AS g
   	ON g.Id = b.GenreId
    WHERE g.[Name] = 'Biography' OR g.[Name] = 'Historical Fiction'
 ORDER BY g.[Name],
		  b.Title

-- 07. Missing Genre
   SELECT l.[Name] 
       AS LibraryName, c.Email
     FROM Libraries 
	   AS l
LEFT JOIN Contacts 
	 AS c 
	 ON l.ContactId = c.Id
  WHERE l.Id NOT IN (
						  SELECT
						DISTINCT lb.LibraryId
						    FROM LibrariesBooks lb
							JOIN Books b ON lb.BookId = b.Id
							JOIN Genres g ON b.GenreId = g.Id
						   WHERE g.[Name] = 'Mystery'
)
ORDER BY l.[Name] ASC;

-- 08. First 3 Books
  SELECT 
 TOP (3) b.Title,
		 b.YearPublished
	  AS [Year],
		 g.[Name]
	  AS [Genger]
    FROM Books
      AS b
    JOIN Genres
      AS g
  	ON g.Id = b.GenreId
   WHERE b.YearPublished > 2000 AND b.Title LIKE '%a%'
      OR b.YearPublished < 1950 AND g.[Name] LIKE '%Fantasy%'
ORDER BY b.Title,
		 b.YearPublished 


-- 09. Authors from UK
SELECT a.[Name],
	   c.Email,
	   c.PostAddress
  FROM Contacts AS c 
  JOIN Authors AS a ON c.Id = A.ContactId
 WHERE RIGHT(PostAddress, 2) = 'UK'
 ORDER BY a.[Name]

 -- 10. Fictions in Denver
 SELECT a.[Name],
		b.Title,
		l.[Name]
	 AS [Library],
		c.PostAddress
	 AS [Library Address]
   FROM Books
     AS b
   JOIN Genres AS g ON b.GenreId = g.Id
   JOIN Authors AS a ON a.Id = b.AuthorId
   JOIN LibrariesBooks AS lb ON b.Id = lb.BookId
   JOIN Libraries AS l ON lb.LibraryId = l.Id
   JOIN Contacts AS c ON c.Id = L.ContactId
  WHERE g.[Name] = 'Fiction' AND
		c.PostAddress LIKE '%Denver%'
ORDER BY B.Title

