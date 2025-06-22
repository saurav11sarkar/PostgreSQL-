-- Active: 1750004681527@@127.0.0.1@5432@ph@public
SELECT * FROM employees;

CREATE VIEW avg_department_salary AS
SELECT department_name, AVG(salary) AS avg_salary
FROM employees
GROUP BY
    department_name;

SELECT * FROM avg_department_salary;

DROP VIEW avg_department_salary;

SELECT * FROM employees WHERE department_name ILIKE '%R%';

CREATE View test_view AS
SELECT employees.employee_name, employees.salary, employees.department_name
FROM employees
WHERE
    department_name ILIKE '%R%';

SELECT * FROM test_view;