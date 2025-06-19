# 🐘 PostgreSQL Ultimate Cheat Sheet: Basic to Advanced

## 📚 Table of Contents
1. [Database Basics](#-database-basics)
2. [Table Operations](#-table-operations)
3. [CRUD Operations](#-crud-operations)
4. [Query Techniques](#-query-techniques)
5. [Joins](#-joins)
6. [Advanced Features](#-advanced-features)
7. [Performance Optimization](#-performance-optimization)
8. [Administration](#-administration)
9. [Useful Shortcuts](#-useful-shortcuts)

---

## 🏗️ Database Basics

### Create/Connect to Database
```sql
-- Create database
CREATE DATABASE mydb;

-- Connect to database
\c mydb

-- List databases
\l

-- Delete database
DROP DATABASE IF EXISTS olddb;
```

### User Management
```sql
-- Create user
CREATE USER dev_user WITH PASSWORD 'secure123';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE mydb TO dev_user;

-- Revoke privileges
REVOKE CREATE ON SCHEMA public FROM dev_user;

-- List users
\du
```

---

## 📊 Table Operations

### Create Table
```sql
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE DEFAULT CURRENT_DATE,
    salary NUMERIC(10,2) CHECK (salary > 0),
    dept_id INT REFERENCES departments(dept_id)
);
```

### Modify Table
```sql
-- Add column
ALTER TABLE employees ADD COLUMN phone VARCHAR(15);

-- Drop column
ALTER TABLE employees DROP COLUMN phone;

-- Rename column
ALTER TABLE employees RENAME COLUMN email TO work_email;

-- Change data type
ALTER TABLE employees ALTER COLUMN salary TYPE DECIMAL(12,2);

-- Add constraint
ALTER TABLE employees ADD CONSTRAINT salary_range CHECK (salary BETWEEN 30000 AND 200000);
```

### Table Maintenance
```sql
-- View table structure
\d employees

-- List all tables
\dt

-- Truncate table (delete all rows)
TRUNCATE TABLE temp_data;

-- Drop table
DROP TABLE IF EXISTS old_data;
```

---

## ✏️ CRUD Operations

### INSERT
```sql
-- Single row
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('John', 'Doe', 'john@example.com', 75000);

-- Multiple rows
INSERT INTO employees (first_name, last_name, email, salary) VALUES
('Jane', 'Smith', 'jane@example.com', 82000),
('Bob', 'Johnson', 'bob@example.com', 68000);

-- Copy from another table
INSERT INTO managers (emp_id, first_name, last_name)
SELECT emp_id, first_name, last_name FROM employees WHERE salary > 100000;
```

### SELECT
```sql
-- Basic select
SELECT * FROM employees;

-- Specific columns
SELECT first_name, last_name, salary FROM employees;

-- With aliases
SELECT first_name AS "First Name", salary*12 AS "Annual Salary" FROM employees;

-- Distinct values
SELECT DISTINCT dept_id FROM employees;

-- Conditional (WHERE)
SELECT * FROM employees WHERE salary > 80000 AND hire_date > '2020-01-01';

-- Pattern matching (LIKE)
SELECT * FROM employees WHERE email LIKE '%@gmail.com';

-- NULL handling
SELECT * FROM employees WHERE phone IS NULL;
```

### UPDATE
```sql
-- Single record
UPDATE employees SET salary = 80000 WHERE emp_id = 101;

-- Multiple columns
UPDATE employees 
SET salary = salary * 1.05, 
    last_raise = CURRENT_DATE 
WHERE hire_date < '2022-01-01';

-- Using subquery
UPDATE employees
SET dept_id = (SELECT dept_id FROM departments WHERE dept_name = 'IT')
WHERE emp_id = 105;
```

### DELETE
```sql
-- Specific rows
DELETE FROM employees WHERE emp_id = 102;

-- All rows (caution!)
DELETE FROM temp_employees;

-- Using join
DELETE FROM employees
USING departments
WHERE employees.dept_id = departments.dept_id 
AND departments.location = 'Remote';
```

---

## 🔍 Query Techniques

### Sorting & Limiting
```sql
-- Basic sorting
SELECT * FROM employees ORDER BY last_name ASC, first_name ASC;

-- Limit results
SELECT * FROM products LIMIT 10;

-- Pagination
SELECT * FROM orders ORDER BY order_date DESC LIMIT 10 OFFSET 20;
```

### Aggregation
```sql
-- Basic aggregates
SELECT 
    COUNT(*) AS total_employees,
    AVG(salary) AS avg_salary,
    MIN(hire_date) AS oldest_hire,
    MAX(salary) AS highest_salary
FROM employees;

-- GROUP BY
SELECT 
    dept_id, 
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id;

-- HAVING (filter groups)
SELECT 
    dept_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 70000;
```

### Subqueries
```sql
-- In WHERE clause
SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- In FROM clause
SELECT dept_avg.dept_id, departments.dept_name, dept_avg.avg_sal
FROM (SELECT dept_id, AVG(salary) AS avg_sal 
      FROM employees GROUP BY dept_id) dept_avg
JOIN departments ON dept_avg.dept_id = departments.dept_id;

-- EXISTS
SELECT * FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);
```

### Common Table Expressions (CTEs)
```sql
-- Basic CTE
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 100000
)
SELECT * FROM high_earners ORDER BY salary DESC;

-- Recursive CTE (for hierarchies)
WITH RECURSIVE org_tree AS (
    -- Base case (top-level managers)
    SELECT emp_id, first_name, last_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case (subordinates)
    SELECT e.emp_id, e.first_name, e.last_name, e.manager_id, ot.level + 1
    FROM employees e
    JOIN org_tree ot ON e.manager_id = ot.emp_id
)
SELECT * FROM org_tree ORDER BY level, last_name;
```

---

## 🤝 Joins

### INNER JOIN
```sql
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
```

### LEFT JOIN (all from left table)
```sql
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;
```

### RIGHT JOIN (all from right table)
```sql
SELECT e.first_name, p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.lead_id;
```

### FULL OUTER JOIN
```sql
SELECT c.customer_name, o.order_date
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;
```

### CROSS JOIN
```sql
SELECT s.size, c.color 
FROM sizes s
CROSS JOIN colors c;
```

### Self Join
```sql
SELECT e.first_name AS employee, m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;
```

---

## 🚀 Advanced Features

### Window Functions
```sql
-- Ranking
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- Partitioning
SELECT 
    dept_id,
    first_name,
    salary,
    AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg_salary,
    salary - AVG(salary) OVER (PARTITION BY dept_id) AS diff_from_avg
FROM employees;

-- Moving average
SELECT 
    order_date,
    amount,
    AVG(amount) OVER (ORDER BY order_date 
                       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM sales;
```

### JSON Support
```sql
-- Create JSON
SELECT json_build_object('id', emp_id, 'name', first_name || ' ' || last_name)
FROM employees;

-- Query JSON
SELECT profile->>'email' AS email
FROM users
WHERE profile->>'status' = 'active';

-- JSON functions
SELECT 
    jsonb_set(settings, '{notifications}', 'false') AS updated_settings
FROM user_preferences;
```

### Full Text Search
```sql
-- Basic search
SELECT title, content
FROM articles
WHERE to_tsvector('english', content) @@ to_tsquery('database & performance');

-- Highlight matches
SELECT 
    title,
    ts_headline(content, to_tsquery('postgresql'), 
                'StartSel=<mark>, StopSel=</mark>') AS highlighted
FROM articles
WHERE to_tsvector(content) @@ to_tsquery('postgresql');
```

### Transactions
```sql
BEGIN;
-- Transfer funds between accounts
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
-- Only commit if both updates succeed
COMMIT;
-- On error: ROLLBACK;
```

---

## ⚡ Performance Optimization

### Indexing
```sql
-- Create index
CREATE INDEX idx_employees_dept ON employees(dept_id);

-- Multi-column index
CREATE INDEX idx_employees_name ON employees(last_name, first_name);

-- Partial index
CREATE INDEX idx_active_high_earners ON employees(salary) 
WHERE is_active = true AND salary > 100000;

-- View index usage
SELECT * FROM pg_indexes WHERE tablename = 'employees';
```

### EXPLAIN
```sql
-- Analyze query plan
EXPLAIN ANALYZE SELECT * FROM employees WHERE dept_id = 5;

-- Verbose output
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 
SELECT d.dept_name, COUNT(*) 
FROM employees e JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
```

### Materialized Views
```sql
-- Create
CREATE MATERIALIZED VIEW monthly_sales AS
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    product_id,
    SUM(quantity) AS total_quantity,
    SUM(amount) AS total_amount
FROM orders
GROUP BY month, product_id;

-- Refresh
REFRESH MATERIALIZED VIEW monthly_sales;

-- Concurrent refresh (PostgreSQL 9.4+)
REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_sales;
```

---

## 🔐 Administration

### Backup & Restore
```bash
# Backup single database
pg_dump -U username -d dbname -f backup.sql

# Backup all databases
pg_dumpall -U postgres -f alldb_backup.sql

# Restore database
psql -U username -d dbname -f backup.sql
```

### Vacuum & Analyze
```sql
-- Manual vacuum
VACUUM (VERBOSE, ANALYZE) employees;

-- Aggressive vacuum (reclaims more space)
VACUUM FULL employees;

-- Update statistics
ANALYZE employees;
```

### Monitoring
```sql
-- Active queries
SELECT pid, usename, query, query_start 
FROM pg_stat_activity 
WHERE state = 'active';

-- Table statistics
SELECT * FROM pg_stat_user_tables;

-- Index usage
SELECT * FROM pg_stat_user_indexes;
```

---

## ⌨️ Useful Shortcuts (psql)

| Command | Description |
|---------|-------------|
| `\?` | Show help |
| `\l` | List databases |
| `\c dbname` | Connect to database |
| `\dt` | List tables |
| `\d table` | Describe table |
| `\du` | List users |
| `\e` | Edit query in external editor |
| `\i filename` | Execute SQL from file |
| `\o filename` | Save output to file |
| `\timing` | Toggle query timing |
| `\x` | Toggle expanded output |
| `\q` | Quit psql |

---

This cheat sheet covers PostgreSQL from basic operations to advanced features. Bookmark it for quick reference! Would you like me to generate a PDF version or create specific examples for your use case?