-- Active: 1750004681527@@127.0.0.1@5432@ph
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    user_id INTEGER REFERENCES users (id) ON DELETE set NULL
);

DROP Table posts;
DROP Table users;

INSERT INTO users (name) VALUES ('John'), ('Jane'), ('Bob');

INSERT INTO
    posts (title, user_id)
VALUES ('Post 1', 1),
    ('Post 2', 1),
    ('Post 3', 2),
    ('Post 4', 3),
    ('Post 5', 3);

select * FROM posts;

select * FROM users;

select * FROM posts WHERE user_id = 3;

INSERT INTO posts (title, user_id) VALUES ('Post 7', 3);

ALTER Table posts alter column user_id SET NOT NULL;

DELETE FROM posts WHERE user_id IS NULL;

DELETE FROM users WHERE id = 3;

SELECT user_id, COUNT(*) FROM posts GROUP BY user_id;