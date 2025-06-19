-- Active: 1750004681527@@127.0.0.1@5432@ph@public
SELECT * FROM users;
SELECT * FROM posts;

SELECT title,name as username FROM posts JOIN users ON posts.user_id = users.id;
SELECT posts.id FROM posts JOIN users ON posts.user_id = users.id;