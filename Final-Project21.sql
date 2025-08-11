CREATE DATABASE blog_management_db;
USE blog_management_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    published_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    commented_at DATETIME NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO posts (user_id, title, content, published_date) VALUES
(1, 'First Post', 'This is the first blog post.', '2025-08-01'),
(2, 'Travel Tips', 'Some useful tips for travel.', '2025-08-02'),
(1, 'Tech Trends', 'Latest updates in technology.', '2025-08-03');

INSERT INTO comments (post_id, user_id, comment_text, commented_at) VALUES
(1, 2, 'Great post!', '2025-08-01 10:00:00'),
(1, 3, 'Thanks for sharing!', '2025-08-01 11:00:00'),
(2, 1, 'Very useful tips.', '2025-08-02 09:30:00'),
(3, 3, 'Interesting insights.', '2025-08-03 14:15:00');

SELECT p.id AS post_id, p.title, u.name AS author, p.published_date, c.comment_text, cu.name AS commenter, c.commented_at
FROM posts p
JOIN users u ON p.user_id = u.id
LEFT JOIN comments c ON p.id = c.post_id
LEFT JOIN users cu ON c.user_id = cu.id
ORDER BY p.published_date DESC, c.commented_at;

SELECT p.id, p.title, p.published_date, u.name AS author
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.name = 'Alice'
ORDER BY p.published_date DESC;

SELECT id, title, published_date
FROM posts
WHERE published_date BETWEEN '2025-08-01' AND '2025-08-02'
ORDER BY published_date DESC;
 