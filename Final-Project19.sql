CREATE DATABASE loan_repayment_db;
USE loan_repayment_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE loans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    principal DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    start_date DATE NOT NULL,
    tenure_months INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    paid_on DATE NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);

INSERT INTO users (name) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Brown');

INSERT INTO loans (user_id, principal, interest_rate, start_date, tenure_months) VALUES
(1, 50000.00, 8.5, '2025-01-01', 24),
(2, 75000.00, 7.2, '2025-03-15', 36),
(3, 30000.00, 9.0, '2025-05-10', 12);

INSERT INTO payments (loan_id, amount, paid_on) VALUES
(1, 2500.00, '2025-02-01'),
(1, 2500.00, '2025-03-01'),
(2, 3000.00, '2025-04-01'),
(3, 2800.00, '2025-06-01'),
(3, 2800.00, '2025-07-01');

SELECT u.name AS borrower, l.id AS loan_id, l.principal, l.interest_rate,
       SUM(p.amount) AS total_paid,
       (l.principal + (l.principal * l.interest_rate / 100)) - SUM(p.amount) AS amount_due
FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p ON l.id = p.loan_id
GROUP BY l.id, u.name, l.principal, l.interest_rate;

SELECT l.id AS loan_id, u.name AS borrower, 
       DATE_ADD(l.start_date, INTERVAL l.tenure_months MONTH) AS due_date
FROM loans l
JOIN users u ON l.user_id = u.id;
