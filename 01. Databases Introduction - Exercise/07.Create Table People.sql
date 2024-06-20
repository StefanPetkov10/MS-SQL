CREATE TABLE [People](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY,
	CHECK (DATALENGTH([Picture]) <= 2000000),
	[Heigth] DECIMAL(3, 2),
	[Weight] DECIMAL(5, 2),
	[Gender] CHAR(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] = 'f'),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)
 )

 INSERT INTO [People]([Name], [Heigth], [Weight], [Gender], [Birthdate])
	VALUES
('Pesho', 1.77, 75.2, 'm', '1998-05-25'),
('Gosho', NULL, NULL, 'm', '1997-03-8'),
('Maria', 1.65, 42.2, 'f', '1998-09-20'),
('viki', NULL, NULL, 'f', '1998-05-25'),
('Vanko', 2.10, 140.5, 'm', '2004-10-8')

SELECT * FROM [People]

ALTER TABLE [People]
ADD CONSTRAINT DF_DefaultBiography DEFAULT ('No biography provided...') FOR [Biography]

TRUNCATE TABLE [People]