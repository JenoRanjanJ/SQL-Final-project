CREATE DATABASE sales_crm;
USE sales_crm;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE leads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    source VARCHAR(100)
);

CREATE TABLE deals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lead_id INT NOT NULL,
    user_id INT NOT NULL,
    stage ENUM('Prospecting', 'Negotiation', 'Closed Won', 'Closed Lost') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    created_at DATE NOT NULL,
    FOREIGN KEY (lead_id) REFERENCES leads(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO leads (name, source) VALUES
('Lead A', 'Website'),
('Lead B', 'Referral'),
('Lead C', 'Email Campaign');

INSERT INTO deals (lead_id, user_id, stage, amount, created_at) VALUES
(1, 1, 'Prospecting', 5000, '2025-08-01'),
(1, 1, 'Negotiation', 5000, '2025-08-03'),
(1, 1, 'Closed Won', 5000, '2025-08-05'),
(2, 2, 'Prospecting', 3000, '2025-08-02'),
(2, 2, 'Closed Lost', 3000, '2025-08-06'),
(3, 3, 'Prospecting', 7000, '2025-08-04');

WITH deal_progression AS (
    SELECT
        d.lead_id,
        l.name AS lead_name,
        u.name AS user_name,
        d.stage,
        d.amount,
        d.created_at,
        ROW_NUMBER() OVER (PARTITION BY d.lead_id ORDER BY d.created_at) AS stage_order
    FROM deals d
    JOIN leads l ON d.lead_id = l.id
    JOIN users u ON d.user_id = u.id
)
SELECT * FROM deal_progression ORDER BY lead_id, stage_order;

SELECT stage, COUNT(*) AS deal_count, SUM(amount) AS total_amount
FROM deals
GROUP BY stage
ORDER BY deal_count DESC;
