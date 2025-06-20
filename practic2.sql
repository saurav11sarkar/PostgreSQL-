-- Active: 1750004681527@@127.0.0.1@5432@ph@public
CREATE TABLE students1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    -- course_id INT REFERENCES courses(cs_id)
);

-- DROP Table students1;

INSERT INTO
    students1 (name, age)
VALUES ('John', 20),
    ('Jane', 22),
    ('Bob', 21);

SELECT * FROM students1;

SELECT name, age FROM students1;

SELECT * FROM students1 WHERE age = 20;

SELECT * FROM students1 ORDER BY name ASC;

SELECT * FROM students1 LIMIT 2;

UPDATE students1 set age = 25 WHERE id = 1;

SELECT * FROM students1;

DELETE FROM students1 WHERE id = 1;

SELECT * FROM students1;

INSERT INTO
    students1 (name, age)
VALUES ('John', 20),
    ('Elan', 23),
    ('Ile', 24);

SELECT * FROM students1 WHERE name ILIKE 'e%';

SELECT age, COUNT(*) FROM students1 GROUP BY age;

CREATE TABLE courses (
    cs_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    duration INT
);

CREATE TABLE students1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    course_id INT REFERENCES courses (cs_id)
);

DROP TABLE students1;
DROP TABLE courses;

INSERT INTO
    courses (name, duration)
VALUES ('Math', 3),
    ('English', 2),
    ('Physics', 4),
    ('Computer', 5),
    ('Chemistry', 3);

SELECT * FROM courses;

INSERT INTO
    students1 (name, age, course_id)
VALUES ('John', 20, 1),
    ('Jane', 22, 2),
    ('Bob', 21, 3),
    ('Elan', 23, 4),
    ('Ile', 24, 5);

SELECT * FROM students1;

SELECT * FROM students1 JOIN courses ON students1.course_id = courses.cs_id;

SELECT AVG(age) FROM students1;
SELECT * FROM students1 WHERE age > (SELECT AVG(age) FROM students1);

SELECT DISTINCT age FROM students1;

SELECT * FROM students1 WHERE age BETWEEN 20 AND 23;

ALTER TABLE students1 ADD COLUMN email VARCHAR(100);
SELECT * FROM students1;

UPDATE students1 SET email = 'john@gmail.com' WHERE email IS NULL;

SELECT name as student_name FROM students1;

SELECT * FROM students1 WHERE age IN(18,20,23);

INSERT INTO students1 (name, age, email, course_id) VALUES('saurav',22,NULL,1);

SELECT age, count(*) FROM students1 GROUP BY age HAVING count(*) >= 2 ;

SELECT * FROM students1 LIMIT 5 OFFSET 5;

SELECT name,age, CASE WHEN age >= 22 THEN 'Adult' ELSE 'Minor' END AS category FROM students1;


