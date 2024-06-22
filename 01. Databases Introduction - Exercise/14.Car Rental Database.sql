CREATE DATABASE [CarRental]
USE [CarRental]

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[DailyRate] DECIMAL(4, 2) NOT NULL,
    [WeeklyRate] DECIMAL(5, 2) NOT NULL,
    [MonthlyRate] DECIMAL(5, 2) NOT NULL,
    [WeekendRate] DECIMAL(5, 2) NOT NULL 
)

INSERT INTO [Categories]([CategoryName], [DailyRate], [WeeklyRate], [MonthlyRate], [WeekendRate])
	VALUES
('Economy', 35.00, 210.00, 800.00, 100.00),
('Compact', 45.00, 270.00, 900.00, 120.00),
('SUV', 55.00, 330.00, 950.00, 150.00)

CREATE TABLE Cars (
    [Id] INT PRIMARY KEY IDENTITY,
    [PlateNumber] VARCHAR(20) NOT NULL,
    [Manufacturer] VARCHAR(100) NOT NULL,
    [Model] VARCHAR(100) NOT NULL,
    [CarYear] INT NOT NULL,
    [CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
    [Doors] INT,
    [Picture] VARCHAR(255),
    [Condition] VARCHAR(100),
    [Available] BIT NOT NULL,
);

INSERT INTO [Cars] ([PlateNumber], [Manufacturer], [Model], [CarYear], [CategoryId], [Doors], [Condition], [Available]) 
	VALUES
('ABC123', 'Toyota', 'Corolla', 2019, 2, 4, 'Excellent', 1),
('XYZ456', 'Honda', 'Civic', 2020, 2, 4, 'Good', 1),
('DEF789', 'Ford', 'Escape', 2018, 3, 4, 'Fair', 0);


CREATE TABLE [Employees] (
    [Id] INT PRIMARY KEY IDENTITY,
    [FirstName] VARCHAR(50) NOT NULL,
    [LastName] VARCHAR(50) NOT NULL,
    [Title] VARCHAR(100),
    [Notes] VARCHAR(255)
);

INSERT INTO [Employees] ([FirstName], [LastName], [Title], [Notes])
	VALUES
('John', 'Doe', 'Manager', 'Experienced employee.'),
('Jane', 'Smith', 'Sales Associate', 'Friendly and helpful.'),
('David', 'Johnson', 'Mechanic', 'Skilled in car maintenance.');

CREATE TABLE [Customers] (
    [Id] INT PRIMARY KEY IDENTITY,
    [DriverLicenceNumber] VARCHAR(20) NOT NULL,
    [FullName] VARCHAR(100) NOT NULL,
    [Address] VARCHAR(255) NOT NULL,
    [City] VARCHAR(100),
    [ZIPCode] VARCHAR(20),
    [Notes] VARCHAR(255)
);


INSERT INTO [Customers] ([DriverLicenceNumber], [FullName], [Address], [City], [ZIPCode], [Notes])
	VALUES
('DL123456', 'Alice Johnson', '123 Main St', 'Anytown', '12345', 'Regular customer.'),
('DL789012', 'Bob Smith', '456 Oak Ave', 'Othertown', '67890', 'New customer.'),
('DL345678', 'Charlie Brown', '789 Elm St', 'Anothertown', '54321', 'Frequent renter.');

CREATE TABLE [RentalOrders] (
    [Id] INT PRIMARY KEY IDENTITY,
    [EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]),
    [CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]),
    [CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]),
    [TankLevel] DECIMAL(4, 2),
    [KilometrageStart] INT,
    [KilometrageEnd] INT,
    [TotalKilometrage] INT,
    [StartDate] DATE,
    [EndDate] DATE,
    [TotalDays] INT,
    [RateApplied] DECIMAL(10, 2),
    [TaxRate] DECIMAL(5, 2),
    [OrderStatus] VARCHAR(50),
    [Notes] VARCHAR(255),
);


INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes) 
	VALUES
(1, 2, 1, 0.75, 5000, 5500, 500, '2024-04-20', '2024-04-25', 5, 270.00, 7.5, 'Completed', 'Customer was satisfied.'),
(2, 1, 2, 0.80, 6000, 6500, 500, '2024-04-22', '2024-04-25', 3, 270.00, 7.5, 'Completed', 'Customer returned the car on time.'),
(3, 3, 3, 0.70, 4000, 4500, 500, '2024-04-23', '2024-04-25', 2, 330.00, 7.5, 'Completed', 'Car required minor maintenance after return.');