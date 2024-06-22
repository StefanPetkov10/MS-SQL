/*16.	Create SoftUni Database*/
CREATE DATABASE SoftUni;
USE SoftUni;

-- Create Towns table
CREATE TABLE Towns (
    Id INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) NOT NULL
);

-- Create Addresses table
CREATE TABLE Addresses (
    Id INT PRIMARY KEY IDENTITY,
    AddressText VARCHAR(255) NOT NULL,
    TownId INT,
    FOREIGN KEY (TownId) REFERENCES Towns(Id)
);

-- Create Departments table
CREATE TABLE Departments (
    Id INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) NOT NULL
);

-- Create Employees table
CREATE TABLE Employees (
    Id INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(100) NOT NULL,
    DepartmentId INT,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    AddressId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
    FOREIGN KEY (AddressId) REFERENCES Addresses(Id)
);
/*17.	Backup Database*/
DROP DATABASE [SoftUni]

/*18.	Basic Insert*/
INSERT INTO Towns (Name) 
	VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

-- Insert data into Departments table
INSERT INTO Departments (Name) 
	VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

-- Insert data into Addresses table
INSERT INTO Addresses (AddressText, TownId) 
	VALUES
('123 Main St, Sofia', 1),
('456 Oak Ave, Plovdiv', 2),
('789 Elm St, Varna', 3),
('101 Pine St, Burgas', 4),
('222 Maple St, Sofia', 1);

-- Insert data into Employees table
INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId) 
	VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 1),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, 2),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, 3),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, 4),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, 5);


/*19.	Basic Select All Fields*/
-- Select all records from the Towns table
SELECT * FROM Towns;

-- Select all records from the Departments table
SELECT * FROM Departments;

-- Select all records from the Employees table
SELECT * FROM Employees;

/*20.	Basic Select All Fields and Order Them*/
SELECT * FROM Towns ORDER BY Name;

-- Select all records from the Departments table sorted alphabetically by name
SELECT * FROM Departments ORDER BY Name;

-- Select all records from the Employees table sorted descending by salary
SELECT * FROM Employees ORDER BY Salary DESC;

/*21.	Basic Select Some Fields*/
SELECT Name FROM Towns ORDER BY Name;

-- Select only the Name column from the Departments table, sorted alphabetically by name
SELECT Name FROM Departments ORDER BY Name;

-- Select only the specified columns from the Employees table, sorted descending by salary
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC;

/*22.	Increase Employees Salary*/
UPDATE Employees SET Salary = Salary * 1.10;

-- Show only the Salary column for all records in the Employees table
SELECT Salary FROM Employees;

/*23.	Decrease Tax Rate*/
USE Hotel
UPDATE Payments SET TaxRate = TaxRate - TaxRate * 0.03;

-- Select only the TaxRate column from the Payments table
SELECT TaxRate FROM Payments;

/*24.	Delete All Records*/
-- Delete all records from the Occupancies table
TRUNCATE TABLE Occupancies;