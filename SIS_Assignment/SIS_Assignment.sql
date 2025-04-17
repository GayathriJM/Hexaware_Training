-- task - 1
CREATE DATABASE SISDB;
USE SISDB;
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);
CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- changes done
ALTER TABLE Teacher ADD COLUMN expertise VARCHAR(100);

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) ON DELETE SET NULL
);

-- changes done
ALTER TABLE Courses 
ADD COLUMN course_code VARCHAR(50);

ALTER TABLE Courses 
MODIFY COLUMN course_code VARCHAR(50) UNIQUE NOT NULL;

CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);
SHOW TABLES;
DESC Students;
DESC Courses;
DESC Enrollments;
DESC Teacher;
DESC Payments;

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('Alice', 'Smith', '1998-02-15', 'alice.smith@example.com', '9876543210'),
('Bob', 'Johnson', '1999-06-22', 'bob.johnson@example.com', '8765432109'),
('Charlie', 'Brown', '2000-01-10', 'charlie.brown@example.com', '7654321098'),
('David', 'Williams', '1997-08-05', 'david.williams@example.com', '6543210987'),
('Emma', 'Davis', '1996-03-12', 'emma.davis@example.com', '5432109876'),
('Frank', 'Miller', '1995-11-23', 'frank.miller@example.com', '4321098765'),
('Grace', 'Lee', '1998-09-30', 'grace.lee@example.com', '3210987654'),
('Henry', 'Clark', '1997-04-18', 'henry.clark@example.com', '2109876543'),
('Ivy', 'Walker', '2000-07-25', 'ivy.walker@example.com', '1098765432'),
('Jack', 'White', '1999-12-05', 'jack.white@example.com', '9876543211');

select * from students;

INSERT INTO Teacher (first_name, last_name, email) VALUES
('John', 'Miller', 'john.miller@example.com'),
('Sarah', 'Wilson', 'sarah.wilson@example.com'),
('Tom', 'Anderson', 'tom.anderson@example.com'),
('Laura', 'Brown', 'laura.brown@example.com'),
('Michael', 'Scott', 'michael.scott@example.com'),
('Emily', 'Davis', 'emily.davis@example.com'),
('Robert', 'Clark', 'robert.clark@example.com'),
('Anna', 'Taylor', 'anna.taylor@example.com'),
('Daniel', 'Harris', 'daniel.harris@example.com'),
('Sophia', 'Martinez', 'sophia.martinez@example.com');

-- changes done
UPDATE Teacher SET expertise = 'DBMS' WHERE teacher_id = 1;
UPDATE Teacher SET expertise = 'Web Development' WHERE teacher_id = 2;
UPDATE Teacher SET expertise = 'Data Structures' WHERE teacher_id = 3;
UPDATE Teacher SET expertise = 'Operating Systems' WHERE teacher_id = 4;
UPDATE Teacher SET expertise = 'Machine Learning' WHERE teacher_id = 5;
UPDATE Teacher SET expertise = 'Software Engineering' WHERE teacher_id = 6;
UPDATE Teacher SET expertise = 'AI' WHERE teacher_id = 7;
UPDATE Teacher SET expertise = 'Cyber Security' WHERE teacher_id = 8;
UPDATE Teacher SET expertise = 'Cloud Computing' WHERE teacher_id = 9;
UPDATE Teacher SET expertise = 'Big Data' WHERE teacher_id = 10;


select * from Teacher;

INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Database Management', 3, 1),
('Web Development', 4, 2),
('Data Structures', 3, 3),
('Operating Systems', 3, 4),
('Machine Learning', 4, 5),
('Software Engineering', 3, 6),
('Artificial Intelligence', 4, 7),
('Cyber Security', 3, 8),
('Cloud Computing', 3, 9),
('Big Data Analytics', 4, 10);

-- changes done
SET SQL_SAFE_UPDATES = 0;

UPDATE Courses SET course_code = 'CS301' WHERE course_name = 'Database Management';
UPDATE Courses SET course_code = 'WD302' WHERE course_name = 'Web Development';
UPDATE Courses SET course_code = 'CS303' WHERE course_name = 'Data Structures';
UPDATE Courses SET course_code = 'CS304' WHERE course_name = 'Operating Systems';
UPDATE Courses SET course_code = 'AI305' WHERE course_name = 'Machine Learning';
UPDATE Courses SET course_code = 'SE306' WHERE course_name = 'Software Engineering';
UPDATE Courses SET course_code = 'AI307' WHERE course_name = 'Artificial Intelligence';
UPDATE Courses SET course_code = 'CY308' WHERE course_name = 'Cyber Security';
UPDATE Courses SET course_code = 'CC309' WHERE course_name = 'Cloud Computing';
UPDATE Courses SET course_code = 'BD310' WHERE course_name = 'Big Data Analytics';

SET SQL_SAFE_UPDATES = 1;

select * from Courses;

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-10'), (2, 1, '2024-01-12'), (3, 1, '2024-01-15'),
(4, 2, '2024-01-18'), (5, 2, '2024-01-20'), (6, 2, '2024-01-22'),
(7, 3, '2024-01-25'), (8, 3, '2024-01-27'), (9, 3, '2024-01-30'),
(10, 4, '2024-02-02'), (1, 4, '2024-02-05'), (2, 4, '2024-02-07'),
(3, 5, '2024-02-10'), (4, 5, '2024-02-12'), (5, 5, '2024-02-15'),
(6, 6, '2024-02-18'), (7, 6, '2024-02-20'), (8, 6, '2024-02-22'),
(9, 7, '2024-02-25'), (10, 7, '2024-02-28'), (1, 7, '2024-03-02'),
(2, 8, '2024-03-05'), (3, 8, '2024-03-07'), (4, 8, '2024-03-10'),
(5, 9, '2024-03-12'), (6, 9, '2024-03-15'), (7, 9, '2024-03-18'),
(8, 10, '2024-03-20'), (9, 10, '2024-03-22'), (10, 10, '2024-03-25');

select * from Enrollments;

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 1500.00, '2024-02-01'),
(2, 2000.00, '2024-02-05'),
(3, 1800.00, '2024-02-10'),
(4, 2200.00, '2024-02-15'),
(5, 2500.00, '2024-02-20'),
(6, 2300.00, '2024-02-25'),
(7, 2700.00, '2024-03-01'),
(8, 2900.00, '2024-03-05'),
(9, 3100.00, '2024-03-10'),
(10, 3300.00, '2024-03-15');

select * from Payments;

-- task - 2
-- 1. Insert a new student

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) 
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

SELECT * FROM Students WHERE email = 'john.doe@example.com';

-- 2. Enroll a student in a course

INSERT INTO Enrollments (student_id, course_id, enrollment_date) 
VALUES (1, 2, '2024-02-20');

SELECT * FROM Enrollments WHERE student_id = 1 AND course_id = 2;

-- 3. Update a teacher's email

UPDATE Teacher 
SET email = 'updated.email@example.com' 
WHERE teacher_id = 1;

SELECT * FROM Teacher WHERE teacher_id = 1;

-- 4. Delete an enrollment record

DELETE FROM Enrollments 
WHERE student_id = 1 AND course_id = 2;

SELECT * FROM Enrollments WHERE student_id = 1 AND course_id = 2;

-- 5. Assign a teacher to a course

UPDATE Courses 
SET teacher_id = 2 
WHERE course_id = 1;

SELECT * FROM Courses WHERE course_id = 1;

-- 6. Delete a student and their enrollments

DELETE FROM Students 
WHERE student_id = 2;

SELECT * FROM Students WHERE student_id = 2;
SELECT * FROM Enrollments WHERE student_id = 2;

-- 7. Update payment amount

UPDATE Payments 
SET amount = 2500.00 
WHERE payment_id = 1;

SELECT * FROM Payments WHERE payment_id = 1;

-- task - 3
-- 1. Calculate the total payments made by a specific student

SELECT S.student_id, S.first_name, S.last_name, SUM(P.amount) AS total_payment
FROM Students S
JOIN Payments P ON S.student_id = P.student_id
WHERE S.student_id = 1
GROUP BY S.student_id, S.first_name, S.last_name;

-- 2. Retrieve a list of courses along with the count of students enrolled in each course

SELECT C.course_id, C.course_name, COUNT(E.student_id) AS total_students
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_id, C.course_name;

-- 3. Find the names of students who have not enrolled in any course

SELECT S.student_id, S.first_name, S.last_name
FROM Students S
LEFT JOIN Enrollments E ON S.student_id = E.student_id
WHERE E.course_id IS NULL;

-- 4. Retrieve the first name, last name of students, and the names of the courses they are enrolled in

SELECT S.student_id, S.first_name, S.last_name, C.course_name
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id;

-- 5. List the names of teachers and the courses they are assigned to

SELECT T.teacher_id, T.first_name, T.last_name, C.course_name
FROM Teacher T
JOIN Courses C ON T.teacher_id = C.teacher_id;

-- 6. Retrieve a list of students and their enrollment dates for a specific course

SELECT S.first_name, S.last_name, C.course_name, E.enrollment_date
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id
WHERE C.course_id = 1;

-- 7. Find the names of students who have not made any payments

SELECT S.student_id, S.first_name, S.last_name
FROM Students S
LEFT JOIN Payments P ON S.student_id = P.student_id
WHERE P.student_id IS NULL;

-- 8. Identify courses that have no enrollments

SELECT C.course_id, C.course_name
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
WHERE E.course_id IS NULL;

-- 9. Identify students who are enrolled in more than one course

SELECT DISTINCT E1.student_id, S.first_name, S.last_name
FROM Enrollments E1
JOIN Enrollments E2 ON E1.student_id = E2.student_id 
AND E1.course_id <> E2.course_id 
JOIN Students S ON E1.student_id = S.student_id;

-- 10. Find teachers who are not assigned to any courses

SELECT T.teacher_id, T.first_name, T.last_name
FROM Teacher T
LEFT JOIN Courses C ON T.teacher_id = C.teacher_id
WHERE C.course_id IS NULL;

-- task - 4
-- 1. Calculate the average number of students enrolled in each course

SELECT AVG(student_count) AS avg_students_per_course
FROM (
    SELECT C.course_id, COUNT(E.student_id) AS student_count
    FROM Courses C
    LEFT JOIN Enrollments E ON C.course_id = E.course_id
    GROUP BY C.course_id
) AS CourseEnrollmentCounts;

-- 2. Identify the student(s) who made the highest payment

SELECT S.student_id, S.first_name, S.last_name, P.amount
FROM Students S
JOIN Payments P ON S.student_id = P.student_id
WHERE P.amount = (SELECT MAX(amount) FROM Payments);

-- 3. Retrieve a list of courses with the highest number of enrollments

SELECT course_id, course_name, total_students
FROM (
    SELECT C.course_id, C.course_name, COUNT(E.student_id) AS total_students
    FROM Courses C
    LEFT JOIN Enrollments E ON C.course_id = E.course_id
    GROUP BY C.course_id, C.course_name
) AS course_counts
WHERE total_students = (SELECT MAX(total_students) 
	FROM (
		SELECT COUNT(student_id) AS total_students 
        FROM Enrollments 
        GROUP BY course_id
	) AS enrollment_counts);

-- 4. Calculate the total payments made to courses taught by each teacher

SELECT T.teacher_id, T.first_name, T.last_name, 
       (SELECT SUM(P.amount) 
        FROM Payments P 
        JOIN Enrollments E ON P.student_id = E.student_id
        JOIN Courses C ON E.course_id = C.course_id
        WHERE C.teacher_id = T.teacher_id) AS total_payment
FROM Teacher T;

-- 5. Identify students who are enrolled in all available courses

SELECT S.student_id, S.first_name, S.last_name
FROM Students S
WHERE (SELECT COUNT(DISTINCT E.course_id) FROM Enrollments E 
WHERE E.student_id = S.student_id) = (SELECT COUNT(*) FROM Courses);

-- 6. Retrieve the names of teachers who have not been assigned to any courses

SELECT T.teacher_id, T.first_name, T.last_name
FROM Teacher T
WHERE NOT EXISTS (SELECT 1 FROM Courses C WHERE C.teacher_id = T.teacher_id);

-- 7. Calculate the average age of all students

SELECT AVG(DATEDIFF(CURDATE(), date_of_birth) / 365) AS avg_age
FROM Students S;

-- 8. Identify courses with no enrollments

SELECT course_id, course_name
FROM Courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM Enrollments);

-- 9. Calculate the total payments made by each student for each course they are enrolled in

SELECT S.student_id, S.first_name, S.last_name, C.course_id, C.course_name, 
       (SELECT SUM(P.amount) 
        FROM Payments P 
        WHERE P.student_id = S.student_id) AS total_payment
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id;

-- 10. Identify students who have made more than one payment

SELECT S.student_id, S.first_name, S.last_name
FROM Students S
WHERE S.student_id IN (
    SELECT P.student_id FROM Payments P GROUP BY P.student_id HAVING COUNT(*) > 1
);

/* 10. My current Payments table contains only one payment per student, the query returns NULL output.
for getting a Non-Empty Output, I am inserting additional payments for some students. */

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 1200.00, '2024-03-01'),
(3, 1400.00, '2024-03-05'),
(4, 1600.00, '2024-03-10');

-- 11. Calculate the total payments made by each student

SELECT S.student_id, S.first_name, S.last_name, SUM(P.amount) AS total_payment
FROM Students S
LEFT JOIN Payments P ON S.student_id = P.student_id
GROUP BY S.student_id, S.first_name, S.last_name;

-- 12. Retrieve a list of course names along with the count of students enrolled in each course

SELECT C.course_id, C.course_name, COUNT(E.student_id) AS total_students
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_id, C.course_name;

-- 13. Calculate the average payment amount made by students

SELECT S.student_id, S.first_name, S.last_name, AVG(P.amount) AS avg_payment
FROM Students S
LEFT JOIN Payments P ON S.student_id = P.student_id
GROUP BY S.student_id, S.first_name, S.last_name;

