CREATE DATABASE complaint_management_db;
USE complaint_management_db;

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE responses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT NOT NULL,
    responder_id INT NOT NULL,
    message TEXT NOT NULL,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);

INSERT INTO departments (name) VALUES
('Water Supply'),
('Electricity'),
('Roads');

INSERT INTO complaints (title, department_id, status) VALUES
('Water leakage in Sector 5', 1, 'Open'),
('Power outage in Block A', 2, 'Resolved'),
('Potholes near Main Street', 3, 'In Progress');

INSERT INTO responses (complaint_id, responder_id, message) VALUES
(1, 101, 'Inspection scheduled for tomorrow.'),
(2, 102, 'Power restored at 3 PM.'),
(3, 103, 'Road repair team dispatched.');

SELECT status, COUNT(*) AS total
FROM complaints
GROUP BY status;

SELECT d.name AS department, COUNT(c.id) AS total_complaints
FROM complaints c
JOIN departments d ON c.department_id = d.id
GROUP BY d.name;
