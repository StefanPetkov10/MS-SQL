CREATE TABLE [Users](
	[Id] INT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY,
	CHECK (DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATE,
	[IsDeleted] BIT NOT NULL
)

INSERT INTO [Users]([Username], [Password], [LastLoginTime], [IsDeleted])
	VALUES
('Gogo', 'spojpe',  '2017-05-15', 1),
('Bobo','epgojro', '2017-08-05', 0),
('Ani',  'rpker', '2017-04-25', 0),
('Sasho',  'rgpjrpe', '2017-05-06', 1),
('Gery', 'pkptkh','2017-01-11', 0)

SELECT * FROM [Users]