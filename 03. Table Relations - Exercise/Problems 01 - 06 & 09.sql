CREATE DATABASE [TableRelations]

GO

USE [TableRelations]

--Problem 1
CREATE TABLE [Passports]
(
	[PassportID] INT PRIMARY KEY IDENTITY(101,1),
	[PassportNumber] VARCHAR(8) NOT NULL
)

--EXEC sp_rename '[Passports].[PassportId]', '[PassportID]', 'COLUMN';


CREATE TABLE [Persons]
(
	[PersonID] INT PRIMARY KEY IDENTITY,
	[FirstName] VARCHAR(50) NOT NULL,
	[Salary] DECIMAL(8,2) NOT NULL,
	[PassportID] INT FOREIGN KEY REFERENCES [Passports]([PassportId]) UNIQUE NOT NULL
)

INSERT INTO Passports
	 VALUES ('N34FG21B'), ('K65LO4R7'), ('ZE657QP2')

INSERT INTO Persons
	 VALUES ('Roberto', 43300, 102),
			('Tom', 56100, 103),
			('Yana', 60200, 101)

ALTER TABLE [Passports]
ADD UNIQUE ([PassportNumber])

--Problem 02
CREATE TABLE Manufacturers
(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32) NOT NULL,
	EstablishedOn DATETIME2
)

CREATE TABLE Models
(
	ModelID INT PRIMARY KEY IDENTITY(101, 1),
	[Name] VARCHAR(32) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers
	 VALUES  ('BMW', '07/03/1916'),
			 ('Tesla', '01/01/2003'),
			 ('Lada', '01/05/1966')

INSERT INTO Models
	 VALUES ('X1', 1),
			('i6', 1),
			('Model S', 2),
			('Model X', 2),
			('Model 3', 2),
			('Nova', 3)


--Problem 03
CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32) NOT NULL
)
CREATE TABLE Exams
(
	ExamID INT PRIMARY KEY IDENTITY(101, 1),
	[Name] VARCHAR(32) NOT NULL
)
CREATE TABLE StudentsExams
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
	CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID) -- Composite primary key
)
INSERT INTO Students
	 VALUES('Mila'),
			('Toni'),
			('Ron')

INSERT INTO Exams
	 VALUES('SpringMVC'),
			('Neo4j'),
			('Oracle 11g')

INSERT INTO StudentsExams
	 VALUES (1, 101),
			(1, 102),
			(2, 101),
			(3, 103),
			(2, 102),
			(2, 103)

SELECT * FROM StudentsExams

--Problem 04
CREATE TABLE [Teachers]
(
[TeacherID] INT PRIMARY KEY IDENTITY(101, 1),
[Name] NVARCHAR(50) NOT NULL,
[ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherID])
)

INSERT INTO [Teachers]([Name], [ManagerID])
     VALUES
	 ('John', NULL),
	 ('Maya', 106),
	 ('Silvia', 106),
	 ('Ted', 105),
	 ('MArk', 101),
	 ('Greta', 101)

	 SELECT * FROM [Teachers]


--Problem 05

CREATE DATABASE [OnlineStore]

GO

USE [OnlineStore]


CREATE TABLE [ItemTypes]
(
	[ItemTypeID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Cities]
(
	[CityID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Items]
(
	[ItemID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID])
)

CREATE TABLE [Customers]
(
	[CustomerID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Birtday] DATETIME2 NOT NULL,
	[CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID])
)

CREATE TABLE [Orders]
(
	[OrderID] INT PRIMARY KEY IDENTITY,
	[CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID])
)


CREATE TABLE [OrderItems]
(
	[OrderID] INT FOREIGN KEY REFERENCES [Orders]([OrderID]),
	[ItemID] INT FOREIGN KEY REFERENCES [Items]([ItemID]),
	PRIMARY KEY([OrderID], [ItemID])
)


--Problem 06
CREATE DATABASE [UniversityDatabase]

GO

USE [UniversityDatabase]

CREATE TABLE [Majors]
(
	[MajorID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Subjects]
(
	[SubjectID] INT PRIMARY KEY IDENTITY,
	[SubjectName] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Students]
(	
	[StudentID] INT PRIMARY KEY IDENTITY,
	[StudentNumber] VARCHAR(20) NOT NULL,
	[StudentName] NVARCHAR(50) NOT NULL,
	[MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID]) NOT NULL
)

CREATE TABLE [Agenda]
(
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID]),
	PRIMARY KEY([StudentID], [SubjectID])
)

CREATE TABLE [Payments]
(
	[PaymentID] INT PRIMARY KEY IDENTITY, --in real life WE WOULD USE GUID
	[PaymentDate] DATETIME2 NOT NULL,
	[PaymentAmount] DECIMAL(8,2) NOT NULL,
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]) NOT NULL
)

ALTER TABLE [Students]
ADD UNIQUE ([StudentNumber])

--Problem 9

USE [Geography]

   SELECT [m].MountainRange,
		  [p].PeakName,
		  [p].Elevation
     FROM [Peaks]
	   AS [p]
LEFT JOIN [Mountains]
	   AS [m]
	   ON [p].MountainId = [m].Id
	WHERE [m].MountainRange = 'Rila'
 ORDER BY [p].Elevation DESC


SELECT *
  FROM [Mountains]
 WHERE [MountainRange] = 'Rila'