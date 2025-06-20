-- Active: 1750004681527@@127.0.0.1@5432@ph@public
CREATE Table employes (
    emp_id INT,
    emp_name VARCHAR(50),
    dep_id INT
)

CREATE Table departements (
    dep_id INT,
    dep_name VARCHAR(50)
)

INSERT INTO
    departements (dep_id, dep_name)
VALUES (101, 'HR'),
    (102, 'Finance')

INSERT INTO
    employes (emp_id, emp_name, dep_id)
VALUES (1, 'John', 101),
    (2, 'Mink', 102);

SELECT * FROM employes

SELECT * FROM departements;

SELECT * FROM employes CROSS JOIN departements;

-- natural join
SELECT * FROM employes NATURAL JOIN departements;