CREATE DATABASE forum_db;
USE forum_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL
);

CREATE TABLE threads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    thread_id INT,
    user_id INT,
    content TEXT NOT NULL,
    parent_post_id INT NULL,
    posted_at DATETIME,
    FOREIGN KEY (thread_id) REFERENCES threads(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_post_id) REFERENCES posts(id)
);

INSERT INTO users (username) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO threads (title, user_id) VALUES
('Best Programming Language?', 1),
('Favorite Movies of All Time', 2);

INSERT INTO posts (thread_id, user_id, content, parent_post_id, posted_at) VALUES
(1, 1, 'I think Python is the best!', NULL, NOW()),
(1, 2, 'I prefer JavaScript.', 1, NOW()),
(1, 3, 'Java is still relevant.', 1, NOW()),
(2, 2, 'I love Inception.', NULL, NOW()),
(2, 1, 'The Godfather is a masterpiece.', 4, NOW()),
(2, 3, 'Interstellar for me.', 4, NOW());

SELECT t.id AS thread_id, t.title, COUNT(p.id) AS total_posts
FROM threads t
LEFT JOIN posts p ON t.id = p.thread_id
GROUP BY t.id, t.title;

SELECT p.id AS post_id, p.content, u.username, p.posted_at, parent.content AS reply_to
FROM posts p
JOIN users u ON p.user_id = u.id
LEFT JOIN posts parent ON p.parent_post_id = parent.id
ORDER BY p.posted_at;
