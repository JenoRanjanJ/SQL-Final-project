CREATE DATABASE employee_timesheet;
USE employee_timesheet;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    dept VARCHAR(100) NOT NULL
);

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE timesheets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    project_id INT NOT NULL,
    hours DECIMAL(5,2) NOT NULL CHECK (hours >= 0),
    date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

INSERT INTO employees (name, dept) VALUES
('Alice', 'IT'),
('Bob', 'Finance'),
('Charlie', 'HR');

INSERT INTO projects (name) VALUES
('Website Redesign'),
('Mobile App Development'),
('Payroll Automation');

INSERT INTO timesheets (emp_id, project_id, hours, date) VALUES
(1, 1, 5.5, '2025-08-01'),
(1, 2, 3.0, '2025-08-02'),
(2, 3, 4.0, '2025-08-01'),
(3, 1, 6.0, '2025-08-03'),
(2, 2, 7.0, '2025-08-04');

SELECT e.id, e.name, p.name AS project_name, SUM(t.hours) AS total_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
JOIN projects p ON t.project_id = p.id
GROUP BY e.id, e.name, p.name;

SELECT e.id, e.name, SUM(t.hours) AS weekly_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
WHERE t.date BETWEEN '2025-08-01' AND '2025-08-07'
GROUP BY e.id, e.name;

SELECT e.id, e.name, SUM(t.hours) AS monthly_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
WHERE MONTH(t.date) = 8 AND YEAR(t.date) = 2025
GROUP BY e.id, e.name;
