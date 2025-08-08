CREATE DATABASE leave_management;
USE leave_management;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE leave_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL
);

CREATE TABLE leave_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    leave_type_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (emp_id) REFERENCES employees(id),
    FOREIGN KEY (leave_type_id) REFERENCES leave_types(id),
    CHECK (from_date <= to_date)
);

INSERT INTO employees (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO leave_types (type_name) VALUES
('Sick Leave'),
('Casual Leave'),
('Annual Leave');

INSERT INTO leave_requests (emp_id, leave_type_id, from_date, to_date, status) VALUES
(1, 1, '2025-08-05', '2025-08-06', 'Approved'),
(2, 3, '2025-08-10', '2025-08-15', 'Pending'),
(3, 2, '2025-08-07', '2025-08-08', 'Rejected'),
(1, 3, '2025-08-20', '2025-08-25', 'Approved');

SELECT e.id, e.name, lt.type_name, SUM(DATEDIFF(lr.to_date, lr.from_date) + 1) AS total_days
FROM leave_requests lr
JOIN employees e ON lr.emp_id = e.id
JOIN leave_types lt ON lr.leave_type_id = lt.id
WHERE lr.status = 'Approved'
GROUP BY e.id, e.name, lt.type_name;

SELECT e.id, e.name, SUM(DATEDIFF(lr.to_date, lr.from_date) + 1) AS total_days_taken
FROM leave_requests lr
JOIN employees e ON lr.emp_id = e.id
WHERE lr.status = 'Approved'
GROUP BY e.id, e.name;
