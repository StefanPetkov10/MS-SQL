CREATE DATABASE [Hotel]

CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Title VARCHAR(100),
    Notes VARCHAR(255)
);

-- Insert data into Employees table
INSERT INTO Employees (Id, FirstName, LastName, Title, Notes) VALUES
(1, 'John', 'Doe', 'Manager', 'Experienced employee.'),
(2, 'Jane', 'Smith', 'Receptionist', 'Friendly and helpful.'),
(3, 'David', 'Johnson', 'Housekeeper', 'Diligent and efficient.');

-- Create Customers table
CREATE TABLE Customers (
    AccountNumber INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    EmergencyName VARCHAR(100),
    EmergencyNumber VARCHAR(20),
    Notes VARCHAR(255)
);

-- Insert data into Customers table
INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
(1001, 'Alice', 'Johnson', '123-456-7890', 'Bob Johnson', '987-654-3210', 'Regular customer.'),
(1002, 'Bob', 'Smith', '234-567-8901', 'Carol Smith', '876-543-2109', 'New customer.'),
(1003, 'Charlie', 'Brown', '345-678-9012', 'David Brown', '765-432-1098', 'Frequent guest.');

-- Create RoomStatus table
CREATE TABLE RoomStatus (
    RoomStatus VARCHAR(50) PRIMARY KEY,
    Notes VARCHAR(255)
);

-- Insert data into RoomStatus table
INSERT INTO RoomStatus (RoomStatus, Notes) VALUES
('Vacant', 'Room is available for occupancy.'),
('Occupied', 'Room is currently occupied by a guest.'),
('Under Maintenance', 'Room is undergoing maintenance.');

-- Create RoomTypes table
CREATE TABLE RoomTypes (
    RoomType VARCHAR(50) PRIMARY KEY,
    Notes VARCHAR(255)
);

-- Insert data into RoomTypes table
INSERT INTO RoomTypes (RoomType, Notes) VALUES
('Standard', 'Basic room with essential amenities.'),
('Deluxe', 'Room with additional features for extra comfort.'),
('Suite', 'Luxurious room with separate living and sleeping areas.');

-- Create BedTypes table
CREATE TABLE BedTypes (
    BedType VARCHAR(50) PRIMARY KEY,
    Notes VARCHAR(255)
);

-- Insert data into BedTypes table
INSERT INTO BedTypes (BedType, Notes) VALUES
('Single', 'Room with a single bed.'),
('Double', 'Room with a double bed.'),
('King', 'Room with a king-sized bed.');

-- Create Rooms table
CREATE TABLE Rooms (
    RoomNumber INT PRIMARY KEY,
    RoomType VARCHAR(50),
    BedType VARCHAR(50),
    Rate DECIMAL(10, 2),
    RoomStatus VARCHAR(50),
    Notes VARCHAR(255),
    FOREIGN KEY (RoomType) REFERENCES RoomTypes(RoomType),
    FOREIGN KEY (BedType) REFERENCES BedTypes(BedType),
    FOREIGN KEY (RoomStatus) REFERENCES RoomStatus(RoomStatus)
);

-- Insert data into Rooms table
INSERT INTO Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes) VALUES
(101, 'Standard', 'Single', 50.00, 'Vacant', 'Cozy room with a single bed.'),
(102, 'Deluxe', 'Double', 80.00, 'Vacant', 'Spacious room with a double bed.'),
(103, 'Suite', 'King', 120.00, 'Occupied', 'Luxurious suite with a king-sized bed.');

-- Create Payments table
CREATE TABLE Payments (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    PaymentDate DATE,
    AccountNumber INT,
    FirstDateOccupied DATE,
    LastDateOccupied DATE,
    TotalDays INT,
    AmountCharged DECIMAL(10, 2),
    TaxRate DECIMAL(5, 2),
    TaxAmount DECIMAL(10, 2),
    PaymentTotal DECIMAL(10, 2),
    Notes VARCHAR(255),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
    FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber)
);

-- Insert data into Payments table
INSERT INTO Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) VALUES
(1, 1, '2024-04-20', 1001, '2024-04-10', '2024-04-15', 5, 250.00, 7.5, 18.75, 268.75, 'Payment for room rental.'),
(2, 2, '2024-04-22', 1002, '2024-04-12', '2024-04-15', 3, 240.00, 7.5, 18.00, 258.00, 'Payment for room rental and phone charges.'),
(3, 3, '2024-04-23', 1003, '2024-04-13', '2024-04-15', 2, 240.00, 7.5, 18.00, 258.00, 'Payment for room rental.');

-- Create Occupancies table
CREATE TABLE Occupancies (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    DateOccupied DATE,
    AccountNumber INT,
    RoomNumber INT,
    RateApplied DECIMAL(10, 2),
    PhoneCharge DECIMAL(10, 2),
    Notes VARCHAR(255),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
    FOREIGN KEY (AccountNumber) REFERENCES Customers(AccountNumber),
    FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)
);

-- Insert data into Occupancies table
INSERT INTO Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) VALUES
(1, 1, '2024-04-10', 1001, 101, 50.00, 10.00, 'Room rental for 5 days.'),
(2, 2, '2024-04-12', 1002, 102, 80.00, 20.00, 'Room rental for 3 days plus phone charges.'),
(3, 3, '2024-04-13', 1003, 103, 120.00, 0.00, 'Room rental for 2 days.');