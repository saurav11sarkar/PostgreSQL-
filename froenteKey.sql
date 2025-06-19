-- Active: 1750004681527@@127.0.0.1@5432@ph
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE posts(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    user_id INTEGER REFERENCES users(id)
);

INSERT INTO users(name) VALUES('John'), ('Jane'), ('Bob');

INSERT INTO posts(title, user_id) VALUES('Post 1', 1), ('Post 2', 1), ('Post 3', 2), ('Post 4', 3), ('Post 5', 3);

select * FROM posts;

select * FROM posts WHERE user_id = 3;