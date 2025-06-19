-- Active: 1750004681527@@127.0.0.1@5432@ph
SELECT * FROM students;

SELECT country, COUNT(*) , avg(age) FROM students GROUP BY country HAVING avg(age) > 20;

SELECT extract(YEAR FROM dob) as year, COUNT(*) FROM students GROUP BY year;

