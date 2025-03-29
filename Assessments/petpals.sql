DROP DATABASE IF EXISTS PetPals;
CREATE DATABASE PetPals;
USE PetPals;

CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Pets (
    PetID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 0), 
    Breed VARCHAR(100) NOT NULL,
    Type ENUM('Dog', 'Cat', 'Other') NOT NULL,
    AvailableForAdoption BOOLEAN NOT NULL DEFAULT TRUE,
    ShelterID INT, 
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID) ON DELETE SET NULL
);

CREATE TABLE Donors (
    DonorID INT PRIMARY KEY AUTO_INCREMENT,
    DonorName VARCHAR(100) NOT NULL
);

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    DonorID INT,
    DonationType ENUM('Cash', 'Item') NOT NULL,
    DonationAmount DECIMAL(10,2) CHECK (DonationAmount >= 0),
    DonationItem VARCHAR(255), 
    DonationDate DATETIME NOT NULL DEFAULT NOW(),
    ShelterID INT NULL,  
    FOREIGN KEY (DonorID) REFERENCES Donors(DonorID) ON DELETE CASCADE,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID) ON DELETE SET NULL
);

CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(100) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY AUTO_INCREMENT,
    ParticipantName VARCHAR(100) NOT NULL,
    ParticipantType ENUM('Shelter', 'Adopter') NOT NULL,
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID) ON DELETE SET NULL
);

CREATE TABLE Adopters (
    AdopterID INT PRIMARY KEY AUTO_INCREMENT,
    AdopterName VARCHAR(100) NOT NULL
);

CREATE TABLE Adoptions (
    AdoptionID INT PRIMARY KEY AUTO_INCREMENT,
    PetID INT UNIQUE,
    AdopterID INT,
    AdoptionDate DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (PetID) REFERENCES Pets(PetID) ON DELETE CASCADE,
    FOREIGN KEY (AdopterID) REFERENCES Adopters(AdopterID) ON DELETE CASCADE
);

INSERT INTO Shelters (Name, Location) VALUES 
('Happy Tails Shelter', 'Chennai'),
('Safe Haven Shelter', 'Bangalore'),
('Rescue Paws', 'Delhi');

INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption, ShelterID) VALUES 
('Bruno', 2, 'Labrador', 'Dog', TRUE, 1),
('Milo', 1, 'Persian', 'Cat', TRUE, 1),
('Oscar', 5, 'Golden Retriever', 'Dog', FALSE, 2),
('Luna', 3, 'Siamese', 'Cat', TRUE, 2),
('Buddy', 4, 'Beagle', 'Dog', TRUE, 3),
('Coco', 6, 'Parrot', 'Other', TRUE, 3);

INSERT INTO Donors (DonorName) VALUES 
('Amit Sharma'),
('Priya Reddy'),
('Rahul Mehta');

INSERT INTO Donations (DonorID, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID) VALUES 
(1, 'Cash', 5000.00, NULL, '2024-01-10 10:30:00', 1),
(2, 'Item', NULL, 'Dog Food', '2024-02-15 11:00:00', 2),
(3, 'Cash', 4500.00, NULL, '2024-03-20 09:45:00', 3);

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES 
('Adopt-A-Pet', '2024-04-10 14:00:00', 'Chennai'),
('Pet Fest', '2024-05-20 10:00:00', 'Bangalore');

INSERT INTO Participants (ParticipantName, ParticipantType, EventID) VALUES 
('Happy Tails Shelter', 'Shelter', 1), 
('Amit Sharma', 'Adopter', 1),
('Safe Haven Shelter', 'Shelter', 2),
('Priya Reddy', 'Adopter', 2);

INSERT INTO Adopters (AdopterName) VALUES 
('Amit Sharma'),
('Priya Reddy'),
('Rahul Mehta');

INSERT INTO Adoptions (PetID, AdopterID, AdoptionDate) VALUES 
(3, 1, '2024-04-15 12:30:00'),  
(5, 2, '2024-05-25 15:00:00'); 

show tables;
desc Shelters;
desc Pets;
desc Donors;
desc Donations;
desc AdoptionEvents;
desc Participants;
desc Adopters;
desc Adoptions;


-- 5. Retrieve a list of available pets.
SELECT Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption = TRUE;

-- 6. Retrieve names of participants for a specific adoption event.
SELECT ParticipantName, ParticipantType FROM Participants WHERE EventID = 1;

-- 7. Stored procedure to update shelter information.
DELIMITER //

CREATE PROCEDURE UpdateShelterInfo(
    IN shelterID INT, 
    IN newName VARCHAR(100), 
    IN newLocation VARCHAR(255)
)
BEGIN
    DECLARE shelterExists INT; 

    SELECT COUNT(*) INTO shelterExists FROM Shelters WHERE ShelterID = shelterID;

    IF shelterExists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Shelter ID';
    ELSE
        UPDATE Shelters 
        SET Name = newName, Location = newLocation 
        WHERE ShelterID = shelterID;
    END IF;
END //

DELIMITER ;

-- 8. Retrieve total donation amount for each shelter.
SELECT s.ShelterID, s.Name, IFNULL(SUM(d.DonationAmount), 0) AS TotalDonations
FROM Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterID 
GROUP BY s.ShelterID, s.Name;

-- 9. Retrieve names of pets without an adopter.
SELECT Name, Age, Breed, Type FROM Pets WHERE PetID NOT IN (SELECT PetID FROM Adoptions);

-- 10. Retrieve total donation amount per month-year.
SELECT DATE_FORMAT(DonationDate, '%Y-%m') AS MonthYear, SUM(DonationAmount) AS TotalAmount
FROM Donations
GROUP BY MonthYear;

-- 11. Retrieve distinct breeds of pets aged 1-3 or older than 5.
SELECT DISTINCT Breed FROM Pets WHERE (Age BETWEEN 1 AND 3) OR (Age > 5);

-- 12. Retrieve available pets and their respective shelters.
SELECT p.Name AS PetName, s.Name AS ShelterName 
FROM Pets p 
JOIN Shelters s ON p.ShelterID = s.ShelterID 
WHERE p.AvailableForAdoption = TRUE;

-- 13. Total number of participants in events held in a specific city.
SELECT COUNT(*) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents ae ON p.EventID = ae.EventID
WHERE ae.Location = 'Chennai';

-- 14. Retrieve unique breeds of pets aged between 1 and 5 years.
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;

-- 15. Retrieve pets that have not been adopted.
SELECT * FROM Pets WHERE PetID NOT IN (SELECT PetID FROM Adoptions);

-- 16. Retrieve adopted pets with adopter names.
SELECT p.Name AS PetName, a.AdopterName 
FROM Adoptions ad
JOIN Pets p ON ad.PetID = p.PetID
JOIN Adopters a ON ad.AdopterID = a.AdopterID;

-- 17. Retrieve all shelters with the count of available pets.
SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePets
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID AND p.AvailableForAdoption = TRUE
GROUP BY s.Name;

-- 18. Find pairs of pets from the same shelter with the same breed.
SELECT p1.Name AS Pet1, p2.Name AS Pet2, p1.Breed, s.Name AS ShelterName
FROM Pets p1
JOIN Pets p2 ON p1.ShelterID = p2.ShelterID AND p1.Breed = p2.Breed AND p1.PetID < p2.PetID
JOIN Shelters s ON p1.ShelterID = s.ShelterID;

-- 19. List all possible combinations of shelters and adoption events.
SELECT s.Name AS ShelterName, ae.EventName AS AdoptionEvent 
FROM Shelters s
CROSS JOIN AdoptionEvents ae;

-- 20. Determine the shelter with the highest number of adopted pets.
SELECT s.Name AS ShelterName, COUNT(a.PetID) AS AdoptedPets
FROM Adoptions a
JOIN Pets p ON a.PetID = p.PetID
JOIN Shelters s ON p.ShelterID = s.ShelterID
GROUP BY s.ShelterID
ORDER BY AdoptedPets DESC
LIMIT 1;

