-- Active: 1750004681527@@127.0.0.1@5432@ph
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    grade CHAR(2),
    course VARCHAR(50),
    email VARCHAR(100),
    dob DATE,
    blood_group VARCHAR(5),
    country VARCHAR(50)
);

SELECT * FROM students;

INSERT INTO students (first_name, last_name, age, grade, course, email, dob, blood_group, country) VALUES
('John', 'Doe', 20, 'A', 'Computer Science', 'john.doe@example.com', '2005-04-15', 'O+', 'USA'),
('Jane', 'Smith', 22, 'B', 'Physics', 'jane.smith@example.com', '2003-08-23', 'A-', 'UK'),
('Alice', 'Brown', 19, 'A', 'Mathematics', 'alice.brown@example.com', '2006-02-12', 'B+', 'Canada'),
('Bob', 'Johnson', 21, 'C', 'Engineering', 'bob.johnson@example.com', '2004-11-30', 'AB-', 'Australia'),
('Charlie', 'Williams', 23, 'B', 'Chemistry', 'charlie.williams@example.com', '2002-05-17', 'O-', 'India'),
('Daisy', 'Miller', 20, 'A', 'Biology', 'daisy.miller@example.com', '2005-07-29', 'A+', 'Germany'),
('Ethan', 'Davis', 22, 'C', 'Economics', 'ethan.davis@example.com', '2003-09-10', 'B-', 'France'),
('Grace', 'Wilson', 19, 'B', 'Psychology', 'grace.wilson@example.com', '2006-01-25', 'AB+', 'Japan'),
('Henry', 'Moore', 21, 'A', 'Literature', 'henry.moore@example.com', '2004-06-05', 'O+', 'South Korea'),
('Ivy', 'Clark', 23, 'C', 'History', 'ivy.clark@example.com', '2002-12-11', 'A-', 'Brazil');

TRUNCATE TABLE students;

drop Table students;

SELECT email AS "Student Email" FROM students;

SELECT * FROM students ORDER BY dob DESC;

SELECT DISTINCT country FROM students;

SELECT * FROM students;

SELECT DISTINCT blood_group FROM students ORDER BY blood_group;

SELECT * FROM students WHERE grade = 'A' and course = 'Computer Science';

SELECT * FROM students WHERE (country = 'USA' OR country = 'UK') and age >= 20;

SELECT upper(first_name) AS "First Name", lower(last_name) AS "Last Name", * FROM students;

SELECT concat(first_name, ' ', last_name) AS "Full Name" FROM students;

SELECT length(first_name) AS "First Name Length" FROM students;

SELECT AVG(age) AS "Average Age" FROM students;
SELECT MAX(age) AS "Max Age" FROM students;
SELECT MIN(age) AS "Min Age" FROM students;
SELECT COUNT(*) AS "count Age" FROM students;
SELECT SUM(age) AS "sum Age" FROM students;

SELECT MAX(length(first_name)) AS "Max First Name Length" FROM students;
SELECT * FROM students WHERE length(first_name) =(SELECT MAX(length(first_name)) FROM students);

SELECT * FROM students WHERE first_name LIKE 'J%';

SELECT * FROM students WHERE country != 'USA';

SELECT * FROM students WHERE email IS NULL;

INSERT INTO students (first_name, last_name, age, grade, course, email, dob, blood_group, country)
VALUES ('John', 'Doe', 20, 'A', 'Computer Science', NULL, '2005-04-15', 'O+', 'USA');

SELECT * FROM students 
WHERE email IS NOT NULL;

SELECT COALESCE(email, 'No Email') AS "Email"  FROM students;

SELECT * FROM students WHERE (country='USA' OR country='UK') AND email IS NOT NULL;
SELECT * FROM students WHERE country IN('USA', 'UK') AND email IS NOT NULL;

SELECT * FROM students WHERE age BETWEEN 20 AND 22;
SELECT * FROM students WHERE dob BETWEEN '2005-01-01' AND '2005-12-31' ORDER BY dob DESC;

SELECT * FROM students WHERE first_name LIKE 'J%';
SELECT * FROM students WHERE first_name ILIKE '__n%';
SELECT * FROM students WHERE first_name ILIKE '__n%';

SELECT * FROM students LIMIT 5;
SELECT * FROM students LIMIT 5 OFFSET 2;
SELECT * FROM students LIMIT 5 OFFSET 5 * 0;
SELECT * FROM students LIMIT 5 OFFSET 5 * 1;

DELETE FROM students WHERE email is NULL;

SELECT * FROM students;



INSERT INTO students (first_name, last_name, age, grade, course, email, dob, blood_group, country) VALUES
('John', 'Doe', 20, 'A', 'Computer Science', NULL, '2005-04-15', 'O+', 'USA');

UPDATE students SET email = 'john.doe@example.com' WHERE email IS NULL;
UPDATE students SET first_name = 'Saurav' WHERE student_id = 12;