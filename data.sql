-- Active: 1750004681527@@127.0.0.1@5432@ph
show TIMEZONE;

SELECT now();

CREATE TABLE timeZ (
    ts TIMESTAMP WITHOUT TIME ZONE,
    tsz TIMESTAMP WITH TIME ZONE
);

INSERT INTO timeZ (ts, tsz) VALUES (now(), now());

SELECT * FROM timeZ;

SELECT CURRENT_DATE;
SELECT now()::date;
SELECT now()::timestamp;
SELECT now()::time;

SELECT to_char(now(), 'DD Mon YYYY');
SELECT to_char(now(), 'DDD');

SELECT (CURRENT_DATE - INTERVAL '1 year') AS "1 year date";

SELECT age(CURRENT_DATE, DATE '2001-11-30');


SELECT age(CURRENT_DATE,dob),dob FROM students;

SELECT extract(DAY FROM dob),* FROM students;

SELECT 1::BOOLEAN;