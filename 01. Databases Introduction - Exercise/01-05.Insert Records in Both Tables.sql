/* 01. Create Database */
CREATE DATABASE [Minions]

USE [Minions]


/* 02. Create table Minions (Id, Name, Age). */
CREATE TABLE [Minions](
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] TINYINT NOT NULL
)
/* Then add a new table Towns (Id, Name). */
CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(70) NOT NULL
)


/* 03. Alter Minions Table */
ALTER TABLE [Minions]
	ADD [TownId] INT FOREIGN KEY REFERENCES [Towns] ([Id]) NOT NULL

/*Allow NULL*/
ALTER TABLE [Minions]
ALTER COLUMN [Age] INT
GO

/* 04. Insert Records in Both Tables */
INSERT INTO [Towns]([Id], [Name])
	VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO [Minions]([Id], [Name], [Age], [TownId])
	VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

SELECT * FROM [Towns]
SELECT * FROM [Minions]

/*05. Truncate Table Minions*/
DELETE FROM [Minions] /*WHERE [Name] ='Kevin';*/