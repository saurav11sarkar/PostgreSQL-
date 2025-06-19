-- Active: 1750004681527@@127.0.0.1@5432@ph
SELECT * FROM person2;

ALTER TABLE person2
    ADD COLUMN email VARCHAR(25)  DEFAULT 'sarkar@gmail.com' NOT NULL;

INSERT INTO person2 VALUES(8, 'sarkar',34, 'sarkar1@gmail.com');

ALTER Table person2
    RENAME COLUMN age to user_age;

ALTER TABLE person2
    ALTER COLUMN user_name TYPE VARCHAR(50);

ALTER TABLE person2
    ALTER COLUMN user_age SET NOT NULL;
ALTER TABLE person2
    ALTER COLUMN user_age DROP NOT NULL;

ALTER TABLE person2
    DROP COLUMN email;

ALTER TABLE person2
    ADD constraint unique_person2_user_age UNIQUE(user_age);

DROP Table person2;

CREATE TABLE person2(
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(25) NOT NULL,
    user_age INT CHECK(user_age >= 18),
    email VARCHAR(25) NOT NULL
);

INSERT INTO person2 VALUES(1, 'sarkar1', 34, 'sarkar1@gmail.com'),(2, 'sarkar2', 24, 'sarkar2@gmail.com');
INSERT INTO person2 VALUES(3, 'sarkar3', 35, 'sarkar3@gmail.com');

TRUNCATE TABLE person2;

ALTER TABLE person2
  ADD constraint unique_person2_email UNIQUE(email);

ALTER TABLE person2
     ALTER COLUMN user_name DROP NOT NULL;

ALTER TABLE person2
  DROP CONSTRAINT unique_person2_user_age;
 