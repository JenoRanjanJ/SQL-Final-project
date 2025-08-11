CREATE DATABASE salary_management_db;
USE salary_management_db;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE salaries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    base DECIMAL(15,2) NOT NULL,
    bonus DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

CREATE TABLE deductions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    reason VARCHAR(100) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

INSERT INTO employees (name) VALUES
('John Doe'),
('Mary Smith'),
('David Johnson');

INSERT INTO salaries (emp_id, month, base, bonus) VALUES
(1, '2025-07-01', 50000.00, 5000.00),
(2, '2025-07-01', 45000.00, 3000.00),
(3, '2025-07-01', 60000.00, 7000.00),
(1, '2025-08-01', 50000.00, 6000.00),
(2, '2025-08-01', 45000.00, 4000.00),
(3, '2025-08-01', 60000.00, 8000.00);

INSERT INTO deductions (emp_id, month, reason, amount) VALUES
(1, '2025-07-01', 'Late coming', 500.00),
(2, '2025-07-01', 'Leave without pay', 1000.00),
(3, '2025-07-01', 'Tax', 2000.00),
(1, '2025-08-01', 'Tax', 1500.00),
(2, '2025-08-01', 'Tax', 1200.00),
(3, '2025-08-01', 'Loan repayment', 2500.00);

SELECT e.name, s.month, 
       s.base + s.bonus AS gross_salary,
       COALESCE(SUM(d.amount), 0) AS total_deductions,
       (s.base + s.bonus) - COALESCE(SUM(d.amount), 0) AS net_salary
FROM salaries s
JOIN employees e ON s.emp_id = e.id
LEFT JOIN deductions d ON s.emp_id = d.emp_id AND s.month = d.month
GROUP BY e.name, s.month, s.base, s.bonus
ORDER BY e.name, s.month;

SELECT e.name, s.month, 
       CASE WHEN s.bonus >= 5000 THEN 'High Bonus' ELSE 'Standard Bonus' END AS bonus_category
FROM salaries s
JOIN employees e ON s.emp_id = e.id
ORDER BY e.name, s.month;
