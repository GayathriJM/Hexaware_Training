CREATE DATABASE PetpalsPlatform;
USE PetpalsPlatform;

CREATE TABLE pets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    breed VARCHAR(100),
    type ENUM('dog', 'cat'), 
    dogBreed VARCHAR(100),
    catColor VARCHAR(50)
);

CREATE TABLE donations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donorName VARCHAR(100),
    amount DECIMAL(10,2),
    donationType ENUM('cash', 'item'), 
    donationDate DATETIME,
    itemType VARCHAR(50)
);

CREATE TABLE adoptionEvents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eventName VARCHAR(100),
    eventDate DATE
);

CREATE TABLE participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eventId INT,
    participantName VARCHAR(100), 
    participantType ENUM('adopter', 'shelter'),
    FOREIGN KEY (eventId) REFERENCES adoptionEvents(id)
);

INSERT INTO pets (name, age, breed, type, dogBreed, catColor) VALUES
('Buddy', 3, 'Golden Retriever', 'Dog', 'Golden Retriever', NULL),
('Whiskers', 2, 'Persian', 'Cat', NULL, 'White'),
('Rocky', 4, 'Bulldog', 'Dog', 'Bulldog', NULL),
('Mittens', 1, 'Siamese', 'Cat', NULL, 'Cream'),
('Max', 5, 'Labrador', 'Dog', 'Labrador', NULL);

select * from pets;

INSERT INTO donations (donorName, amount, donationType, donationDate, itemType) VALUES
('Gayathri', 50.00, 'Cash', '2024-12-10 10:00:00', NULL),
('Divya', 100.00, 'Cash', '2024-12-12 15:30:00', NULL),
('Shri', 75.00, 'Item', NULL, 'Dog Food'),
('Neha', 120.00, 'Item', NULL, 'Blankets'),
('Anu', 200.00, 'Cash', '2024-12-15 09:45:00', NULL);

select * from donations;

INSERT INTO adoptionEvents (eventName, eventDate) VALUES
('Happy Paws Day', '2024-12-20'),
('AdoptFest', '2024-12-25'),
('Puppy Parade', '2025-01-05'),
('Cat Carnival', '2025-01-10'),
('New Year Adoptions', '2025-01-15');

select * from adoptionEvents;

INSERT INTO participants (eventId, participantName, participantType) VALUES
(1, 'Alice', 'Adopter'),
(1, 'Sunrise Shelter', 'Shelter'),
(2, 'Bob', 'Adopter'),
(3, 'Eve', 'Adopter'),
(4, 'Pawsome Shelter', 'Shelter');

select * from participants;

