CREATE DATABASE asset_mgmt_db;
USE asset_mgmt_db;

CREATE TABLE assets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    asset_id INT NOT NULL,
    user_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    returned_date DATE NULL,
    FOREIGN KEY (asset_id) REFERENCES assets(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO assets (name, category) VALUES
('Laptop Dell XPS 13', 'Laptop'),
('Office Chair Ergo', 'Furniture'),
('iPhone 13', 'Mobile'),
('Projector Epson X200', 'Electronics');

INSERT INTO users (name) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Brown');

INSERT INTO assignments (asset_id, user_id, assigned_date, returned_date) VALUES
(1, 1, '2025-08-01', NULL),
(2, 2, '2025-07-20', '2025-08-05'),
(3, 3, '2025-07-15', NULL),
(4, 1, '2025-07-01', '2025-07-30');

SELECT a.id, a.name, a.category
FROM assets a
LEFT JOIN assignments ass ON a.id = ass.asset_id AND ass.returned_date IS NULL
WHERE ass.asset_id IS NULL;

SELECT u.name AS user_name, a.name AS asset_name, ass.assigned_date, ass.returned_date
FROM assignments ass
JOIN users u ON ass.user_id = u.id
JOIN assets a ON ass.asset_id = a.id
ORDER BY ass.assigned_date DESC;
