CREATE DATABASE LibraryDb

GO

USE LibraryDb

GO

-- 01. DDL

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Contacts(
	Id INT PRIMARY KEY IDENTITY,
	Email NVARCHAR(100),
	PhoneNumber NVARCHAR(20),
	PostAddress NVARCHAR(200),
	Website NVARCHAR(50)
)

CREATE TABLE Authors(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	ContactId INT FOREIGN KEY REFERENCES Contacts(Id) NOT NULL
)

CREATE TABLE Libraries(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	ContactId INT FOREIGN KEY REFERENCES Contacts(Id) NOT NULL
)

CREATE TABLE Books(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) NOT NULL,
	YearPublished INT NOT NULL,
	ISBN NVARCHAR(13) UNIQUE NOT NULL,
	AuthorId INT FOREIGN KEY REFERENCES Authors(Id) NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL
)

CREATE TABLE LibrariesBooks(
	LibraryId INT FOREIGN KEY REFERENCES Libraries(Id),
	BookId INT FOREIGN KEY REFERENCES Books(Id),
	PRIMARY KEY (LibraryId, BookId)
)

-- 02. Insert

INSERT INTO Contacts (Email, PhoneNumber, PostAddress, Website)
VALUES
(NULL, NULL, NULL, NULL),  -- ID 21
(NULL, NULL, NULL, NULL),  -- ID 22
('stephen.king@example.com', '+4445556666', '15 Fiction Ave, Bangor, ME', 'www.stephenking.com'),  -- ID 23
('suzanne.collins@example.com', '+7778889999', '10 Mockingbird Ln, NY, NY', 'www.suzannecollins.com');  -- ID 24

INSERT INTO Authors ([Name], ContactId)
VALUES
('George Orwell', 21),  -- ID 16
('Aldous Huxley', 22),  -- ID 17
('Stephen King', 23),  -- ID 18
('Suzanne Collins', 24);  -- ID 19

INSERT INTO Books (Title, YearPublished, ISBN, AuthorId, GenreId)
VALUES
('1984', 1949, '9780451524935', 16, 2),  -- ID 36
('Animal Farm', 1945, '9780451526342', 16, 2),  -- ID 37
('Brave New World', 1932, '9780060850524', 17, 2),  -- ID 38
('The Doors of Perception', 1954, '9780060850531', 17, 2),  -- ID 39
('The Shining', 1977, '9780307743657', 18, 9),  -- ID 40
('It', 1986, '9781501142970', 18, 9),  -- ID 41
('The Hunger Games', 2008, '9780439023481', 19, 7),  -- ID 42
('Catching Fire', 2009, '9780439023498', 19, 7),  -- ID 43
('Mockingjay', 2010, '9780439023511', 19, 7);  -- ID 44

INSERT INTO LibrariesBooks (LibraryId, BookId)
VALUES
(1, 36),
(1, 37),
(2, 38),
(2, 39),
(3, 40),
(3, 41),
(4, 42),
(4, 43),
(5, 44);

-- 03. Update

UPDATE Contacts
SET Website = CONCAT('www.',LOWER(REPLACE(Authors.[Name], ' ', '')), '.com')
FROM Authors
WHERE Contacts.Id = Authors.ContactId
AND Contacts.Website IS NULL;

-- 04. Delete
DECLARE @AuthorId INT;
SET @AuthorId = (SELECT Id FROM Authors WHERE [Name] = 'Alex Michaelides');

DELETE FROM LibrariesBooks 
      WHERE BookId = (
						SELECT Id 
						  FROM Books 
						 WHERE AuthorId = @AuthorId
					 )
DELETE FROM Books 
      WHERE AuthorId = (
						SELECT Id 
						  FROM Authors 
						  WHERE Id = @AuthorId
					 )

DELETE FROM Authors
      WHERE Id = @AuthorId


