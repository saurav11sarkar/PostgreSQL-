-- Active: 1750004681527@@127.0.0.1@5432@ph@public
SELECT * FROM users;

SELECT * FROM posts;

INSERT INTO users (name) VALUES ('saurav');

INSERT INTO posts (title, user_id) VALUES ('hello', NULL);

SELECT title, name as username
FROM posts
    JOIN users ON posts.user_id = users.id;

SELECT posts.id FROM posts JOIN users ON posts.user_id = users.id;

SELECT * FROM users JOIN posts ON posts.user_id = users.id;

SELECT * FROM posts LEFT JOIN users ON posts.user_id = users.id;
SELECT * FROM users RIGHT JOIN posts ON users.id = posts.user_id;

SELECT * FROM posts FULL OUTER JOIN users ON posts.user_id = users.id;