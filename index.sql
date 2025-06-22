-- Active: 1750004681527@@127.0.0.1@5432@ph@public
SELECT * FROM employees;

EXPLAIN ANALYSE SELECT * FROM employees WHERE employee_name = 'Ella King';

create INDEX idx_emplayee_name ON employees(employee_name);
show data_directory;