CREATE DATABASE voting_system_db;
USE voting_system_db;

CREATE TABLE polls (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question VARCHAR(255) NOT NULL
);

CREATE TABLE options (
    id INT PRIMARY KEY AUTO_INCREMENT,
    poll_id INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(id)
);

CREATE TABLE votes (
    user_id INT NOT NULL,
    option_id INT NOT NULL,
    voted_at DATETIME NOT NULL,
    PRIMARY KEY (user_id, option_id),
    FOREIGN KEY (option_id) REFERENCES options(id)
);

INSERT INTO polls (question) VALUES
('What is your favorite programming language?'),
('Which season do you like most?');

INSERT INTO options (poll_id, option_text) VALUES
(1, 'Python'),
(1, 'Java'),
(1, 'JavaScript'),
(2, 'Summer'),
(2, 'Winter'),
(2, 'Rainy');

INSERT INTO votes (user_id, option_id, voted_at) VALUES
(1, 1, '2025-08-09 10:00:00'),
(2, 3, '2025-08-09 10:05:00'),
(3, 1, '2025-08-09 10:10:00'),
(1, 5, '2025-08-09 10:15:00'),
(2, 4, '2025-08-09 10:20:00');

SELECT o.option_text, COUNT(v.user_id) AS vote_count
FROM options o
LEFT JOIN votes v ON o.id = v.option_id
WHERE o.poll_id = 1
GROUP BY o.option_text;

SELECT * FROM votes WHERE user_id = 1;
