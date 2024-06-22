CREATE DATABASE [Movies]

CREATE TABLE [Directors](
	[Id] INT PRIMARY KEY IDENTITY,
	[DirectorName] VARCHAR(50) NOT NULL,
	[Notes] VARCHAR(200) DEFAULT NULL
)

INSERT INTO [Directors]([DirectorName])
	VALUES
('Stefan'),
('Pesho'),
('Gosho'),
('Misho'),
('Petko')


CREATE TABLE [Genres](
[Id] INT PRIMARY KEY IDENTITY,
[GenresName] VARCHAR(50) NOT NULL,
[Notes] VARCHAR(200) DEFAULT NULL
)

INSERT INTO [Genres]([GenresName])
	VALUES
('Mitko'),
('Kiko'),
('Mert'),
('Vanko'),
('Rosen')

CREATE TABLE [Categories] (
[Id] INT PRIMARY KEY IDENTITY,
[CategoryName] VARCHAR(50) NOT NULL,
[Notes] VARCHAR(200) DEFAULT NULL
)

INSERT INTO [Categories]([CategoryName])
	VALUES
('Toto'),
('Elko'),
('Nasko'),
('Bobi'),
('Ceci')

CREATE TABLE [Movies](
	[Id] INT PRIMARY KEY IDENTITY,
    [Title] VARCHAR(100) NOT NULL,
    [DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]) NOT NULL,
    [CopyrightYear] INT,
    [Length] INT,
    [GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]) NOT NULL,
    [CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]) NOT NULL,
    [Rating] DECIMAL(3,1),
    [Notes] VARCHAR(200) DEFAULT NULL
)

INSERT INTO [Movies]([Title], [DirectorId], [CopyrightYear], [Length], [GenreId], [CategoryId], [Rating])
	VALUES
('Inception', 1, 2010, 148, 3, 1, 8.8),
('Pulp Fiction', 2, 1994, 154, 2, 2, 8.9),
('Jurassic Park', 3, 1993, 127, 1, 1, 8.1),
('Goodfellas', 4, 1990, 146, 2, 2, 8.7),
('Avatar', 5, 2009, 162, 3, 3, 7.8);

SELECT * FROM [Movies]