CREATE DATABASE project_management_tracker;
USE project_management_tracker;

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    status ENUM('Pending', 'In Progress', 'Completed') NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

CREATE TABLE task_assignments (
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (task_id, user_id)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

INSERT INTO projects (name) VALUES
('Website Redesign'),
('Mobile App Development');

INSERT INTO tasks (project_id, name, status) VALUES
(1, 'Design UI', 'Pending'),
(1, 'Develop Backend', 'In Progress'),
(2, 'Create Wireframes', 'Completed');

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO task_assignments (task_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3);

SELECT p.name AS project_name, t.name AS task_name, t.status, u.name AS assigned_user
FROM tasks t
JOIN projects p ON t.project_id = p.id
JOIN task_assignments ta ON t.id = ta.task_id
JOIN users u ON ta.user_id = u.id;

SELECT status, COUNT(*) AS task_count
FROM tasks
GROUP BY status;
