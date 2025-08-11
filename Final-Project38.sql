CREATE DATABASE qr_code_entry_log_db;
USE qr_code_entry_log_db;

CREATE TABLE locations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE entry_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    entry_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

INSERT INTO locations (name) VALUES
('Main Office'),
('Warehouse'),
('Conference Hall');

INSERT INTO users (name) VALUES
('John Doe'),
('Alice Smith'),
('Robert Brown');

INSERT INTO entry_logs (user_id, location_id, entry_time) VALUES
(1, 1, '2025-08-01 08:45:00'),
(2, 2, '2025-08-01 09:10:00'),
(3, 1, '2025-08-01 09:30:00'),
(1, 3, '2025-08-02 10:15:00'),
(2, 1, '2025-08-02 11:00:00');

SELECT location_id, COUNT(*) AS total_entries
FROM entry_logs
GROUP BY location_id;

SELECT *
FROM entry_logs
WHERE entry_time BETWEEN '2025-08-01 00:00:00' AND '2025-08-01 23:59:59';
