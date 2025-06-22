-- Active: 1750004681527@@127.0.0.1@5432@ph@public
-- CREATE TRIGGER TR BEFORE DELETE ON user FOR EACH ROW EXECUTE FUNCTION delete_user();

create Table my_user ( name VARCHAR(50), email VARCHAR(50) );

INSERT INTO
    my_user (name, email)
VALUES ('John', 'john@gmail.com'),
    ('Jane', 'jane@gmail.com'),
    ('Bob', 'bob@gmail.com');

SELECT * FROM my_user;

CREATE TABLE delete_user_aduilt (
    delete_user_name VARCHAR(50),
    deleteAt TIMESTAMP
);

SELECT * FROM delete_user_aduilt;

-- tigger funtion
CREATE OR REPLACE FUNCTION delete_user()
RETURNS TRIGGER
LANGUAGE plpgsql  
AS $$
BEGIN
  INSERT INTO delete_user_aduilt (delete_user_name, deleteAt)
  VALUES (OLD.name, now());

  RAISE NOTICE 'User added to delete_user_aduilt table';
  RETURN OLD;
END;
$$;

CREATE OR REPLACE TRIGGER save_delete_user_trigger
BEFORE DELETE ON my_user
FOR EACH ROW
EXECUTE FUNCTION delete_user();

DELETE FROM my_user WHERE name = 'Bob';
SELECT * FROM delete_user_aduilt;