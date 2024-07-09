-- 11. Authors with Books
CREATE FUNCTION udf_AuthorsWithBooks(@name NVARCHAR(100))
    RETURNS INT
			 AS
		  BEGIN
					DECLARE @authorId INT;
					SET @authorId = (
										SELECT Id
										  FROM Authors
										 WHERE [Name] = @name
					)

					DECLARE @authorsWithBooksCount INT
					SET @authorsWithBooksCount = (
													SELECT COUNT(*)
													  FROM Books
													 WHERE AuthorId = @authorId
					)

					RETURN @authorsWithBooksCount
		    END

SELECT dbo.udf_AuthorsWithBooks('J.K. Rowling')


-- 12. Search by Genre
CREATE PROCEDURE usp_SearchByGenre @genreName NVARCHAR(30)
			  AS
		   BEGIN
					SELECT 
				            b.Title,
				   		    b.YearPublished
				   	     AS [Year],
							b.ISBN,
							a.[Name]
						 AS Author,
				   		  g.[Name]
				   	     AS [Genger]
				       FROM Books
				          AS b
				        JOIN Genres
				          AS g
				       	  ON g.Id = b.GenreId
						JOIN Authors
				          AS a
				       	  ON a.Id = b.AuthorId
					   WHERE g.[Name]  = @genreName
				    ORDER BY b.Title
		     END

EXEC usp_SearchByGenre 'Fantasy'