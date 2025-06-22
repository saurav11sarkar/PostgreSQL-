-- Active: 1750004681527@@127.0.0.1@5432@ph@public
SELECT * FROM employees;

CREATE FUNCTION emp_count()
RETURNS INT 
LANGUAGE SQL
AS $$
    SELECT COUNT(*) FROM employees;
$$;

SELECT emp_count ();

SELECT COUNT(*) FROM employees;

CREATE FUNCTION del_emp()
RETURNS VOID
LANGUAGE SQL
AS $$
    DELETE FROM employees WHERE employee_id = 30;
$$;

SELECT del_emp ();

CREATE FUNCTION del_emp_id(p_emp_id INT)
RETURNS VOID
LANGUAGE SQL
AS $$
    DELETE FROM employees WHERE employee_id = p_emp_id;
$$;

-- Call the function
SELECT del_emp_id (29);

CREATE PROCEDURE remove_emp()
LANGUAGE plpgsql
AS $$
   BEGIN
      DELETE FROM employees WHERE employee_id = 28;
   END 
$$;

CALL remove_emp ();

SELECT * FROM employees;

CREATE PROCEDURE remove_emp_var(p_emp_id INT)
LANGUAGE plpgsql
AS $$
  DECLARE test_var INT;
   BEGIN
   SELECT employee_id INTO test_var FROM employees WHERE employee_id = p_emp_id;
      DELETE FROM employees WHERE employee_id = test_var;
      RAISE NOTICE 'Employee removed successfully';
   END 
$$;

drop Procedure remove_emp_var (INT);

CALL remove_emp_var (68);

SELECT * FROM employees;

