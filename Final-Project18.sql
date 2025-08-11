CREATE DATABASE bank_transactions_db;
USE bank_transactions_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    type ENUM('deposit', 'withdrawal', 'transfer') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

INSERT INTO users (name) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Brown');

INSERT INTO accounts (user_id, balance) VALUES
(1, 1000.00),
(2, 2500.00),
(3, 500.00);

INSERT INTO transactions (account_id, type, amount, timestamp) VALUES
(1, 'deposit', 500.00, '2025-08-01 10:00:00'),
(1, 'withdrawal', 200.00, '2025-08-02 14:30:00'),
(2, 'deposit', 1000.00, '2025-08-01 09:15:00'),
(2, 'transfer', 300.00, '2025-08-03 11:20:00'),
(3, 'withdrawal', 100.00, '2025-08-02 08:45:00');

SELECT t.id AS transaction_id, u.name AS user_name, a.id AS account_id,
       t.type, t.amount, t.timestamp
FROM transactions t
JOIN accounts a ON t.account_id = a.id
JOIN users u ON a.user_id = u.id
ORDER BY t.timestamp;

WITH balance_calc AS (
    SELECT 
        a.id AS account_id,
        a.user_id,
        SUM(CASE 
                WHEN t.type = 'deposit' THEN t.amount
                WHEN t.type = 'withdrawal' THEN -t.amount
                WHEN t.type = 'transfer' THEN -t.amount
                ELSE 0
            END) + a.balance AS calculated_balance
    FROM accounts a
    LEFT JOIN transactions t ON a.id = t.account_id
    GROUP BY a.id, a.user_id
)
SELECT u.name AS user_name, bc.calculated_balance
FROM balance_calc bc
JOIN users u ON bc.user_id = u.id;
