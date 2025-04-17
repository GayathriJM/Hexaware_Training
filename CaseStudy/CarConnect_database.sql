 CREATE DATABASE carconnectdb;
 USE carconnectdb;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Address (
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZIP CHAR(10) NOT NULL,
    AddressType ENUM('Home', 'Office', 'Other') NOT NULL DEFAULT 'Home',
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

CREATE TABLE Vehicle (
    VehicleID INT PRIMARY KEY AUTO_INCREMENT,
    Model VARCHAR(50) NOT NULL,
    Make VARCHAR(50) NOT NULL,
    Year INT NOT NULL CHECK (Year >= 1900),
    Color VARCHAR(30) NOT NULL,
    RegistrationNumber VARCHAR(20) UNIQUE NOT NULL,
    DailyRate DECIMAL(10,2) NOT NULL CHECK (DailyRate > 0),
    Availability BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL CHECK (TotalCost >= 0),
    Status ENUM('Pending', 'Confirmed', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID) ON DELETE CASCADE
);

CREATE TABLE Role (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Admin (
    AdminID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID INT NOT NULL,
    JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID) ON DELETE CASCADE
); 

SHOW tables;
DESC customer;
DESC Address;
DESC Vehicle;
DESC Reservation;
DESC Role;
DESC Admin;

INSERT INTO Role (RoleName) VALUES 
('Super Admin'),
('Fleet Manager'),
('Support Staff'),
('Booking Agent'),
('IT Admin'),
('Customer Support'),
('Operations Head'),
('Vehicle Inspector'),
('System Analyst'),
('Field Executive');

select * from Role;

INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber, Username, PasswordHash)
VALUES
('Gayathri', 'Manivannan', 'gayathri.manivannan@example.com', '9876543210', 'gayathri_m', SHA2('pass123', 256)),
('Divya', 'Raj', 'divya.raj@example.com', '9876543211', 'divya_raj', SHA2('pass123', 256)),
('Subashini', 'Murthy', 'subashini.m@example.com', '9876543212', 'subashini_m', SHA2('pass123', 256)),
('Meena', 'Lakshmi', 'meena.lak@example.com', '9876543213', 'meena_l', SHA2('pass123', 256)),
('Vignesh', 'Prabhu', 'vignesh.p@example.com', '9876543214', 'vicky_p', SHA2('pass123', 256)),
('Kirthika', 'Mohan', 'kirthika.m@example.com', '9876543215', 'kirthika_m', SHA2('pass123', 256)),
('Saravanan', 'Ravi', 'saravanan.r@example.com', '9876543216', 'sara_r', SHA2('pass123', 256)),
('Kavya', 'Sri', 'kavya.sri@example.com', '9876543217', 'kavya_s', SHA2('pass123', 256)),
('Dinesh', 'Varun', 'dinesh.v@example.com', '9876543218', 'dinesh_v', SHA2('pass123', 256)),
('Priya', 'Anand', 'priya.anand@example.com', '9876543219', 'priya_a', SHA2('pass123', 256));

select * from customer;

INSERT INTO Address (CustomerID, Street, City, State, ZIP, AddressType)
VALUES
(1, 'No 10, MG Road', 'Chennai', 'Tamil Nadu', '600001', 'Home'),
(2, '5A, Anna Nagar', 'Madurai', 'Tamil Nadu', '625020', 'Office'),
(3, '12, Gandhi Street', 'Coimbatore', 'Tamil Nadu', '641001', 'Home'),
(4, '8/3, Lakshmi Puram', 'Salem', 'Tamil Nadu', '636004', 'Home'),
(5, '23, Park View', 'Trichy', 'Tamil Nadu', '620017', 'Other'),
(6, '11A, Cross Road', 'Vellore', 'Tamil Nadu', '632001', 'Home'),
(7, '67, Anna Salai', 'Tirunelveli', 'Tamil Nadu', '627002', 'Home'),
(8, 'B-45, Ram Nagar', 'Erode', 'Tamil Nadu', '638011', 'Office'),
(9, '3C, Lotus Avenue', 'Karur', 'Tamil Nadu', '639002', 'Home'),
(10, '9/2, Ponnusamy St', 'Thanjavur', 'Tamil Nadu', '613001', 'Other');

select * from Address;

INSERT INTO Vehicle (Model, Make, Year, Color, RegistrationNumber, DailyRate)
VALUES
('Swift', 'Maruti', 2020, 'Red', 'TN01AB1234', 850.00),
('i10', 'Hyundai', 2019, 'Blue', 'TN02CD5678', 750.00),
('City', 'Honda', 2021, 'White', 'TN03EF9101', 1250.00),
('Baleno', 'Maruti', 2022, 'Grey', 'TN04GH1213', 900.00),
('Altroz', 'Tata', 2020, 'Black', 'TN05IJ1415', 1000.00),
('Nexon', 'Tata', 2021, 'Silver', 'TN06KL1617', 1300.00),
('Ertiga', 'Maruti', 2018, 'Blue', 'TN07MN1819', 1100.00),
('Creta', 'Hyundai', 2023, 'White', 'TN08OP2021', 1500.00),
('Innova', 'Toyota', 2019, 'Gold', 'TN09QR2223', 1600.00),
('Kiger', 'Renault', 2021, 'Red', 'TN10ST2425', 950.00);

select * from Vehicle;


INSERT INTO Reservation (CustomerID, VehicleID, StartDate, EndDate, TotalCost, Status)
VALUES
(1, 3, NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY), 2500.00, 'Confirmed'),
(2, 1, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 2550.00, 'Pending'),
(3, 5, NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), 1000.00, 'Completed'),
(4, 2, NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY), 1500.00, 'Cancelled'),
(5, 4, NOW(), DATE_ADD(NOW(), INTERVAL 4 DAY), 3600.00, 'Confirmed'),
(6, 6, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 3900.00, 'Confirmed'),
(7, 7, NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), 1100.00, 'Completed'),
(8, 8, NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY), 3000.00, 'Confirmed'),
(9, 9, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY), 8000.00, 'Pending'),
(10, 10, NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), 950.00, 'Confirmed');

select * from Reservation;

INSERT INTO Admin (FirstName, LastName, Email, PhoneNumber, Username, PasswordHash, RoleID)
VALUES
('Karthik', 'Raman', 'karthik.r@example.com', '9000000001', 'karthik_admin', SHA2('admin123', 256), 1),
('Lakshmi', 'Devi', 'lakshmi.d@example.com', '9000000002', 'lakshmi_admin', SHA2('admin123', 256), 2),
('Bala', 'Krishnan', 'bala.k@example.com', '9000000003', 'bala_k', SHA2('admin123', 256), 3),
('Geetha', 'Mohan', 'geetha.m@example.com', '9000000004', 'geetha_m', SHA2('admin123', 256), 4),
('Manoj', 'Sankar', 'manoj.s@example.com', '9000000005', 'manoj_s', SHA2('admin123', 256), 5),
('Nithya', 'Ravi', 'nithya.r@example.com', '9000000006', 'nithya_r', SHA2('admin123', 256), 6),
('Ramesh', 'Babu', 'ramesh.b@example.com', '9000000007', 'ramesh_b', SHA2('admin123', 256), 7),
('Devi', 'Shree', 'devi.s@example.com', '9000000008', 'devi_s', SHA2('admin123', 256), 8),
('Siva', 'Anand', 'siva.a@example.com', '9000000009', 'siva_a', SHA2('admin123', 256), 9),
('Radha', 'Krishnan', 'radha.k@example.com', '9000000010', 'radha_k', SHA2('admin123', 256), 10);

select * from Admin;

