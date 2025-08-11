CREATE DATABASE donation_management_db;
USE donation_management_db;

CREATE TABLE donors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE causes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL
);

CREATE TABLE donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    cause_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    donated_at DATE NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (cause_id) REFERENCES causes(id)
);

INSERT INTO donors (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Johnson');

INSERT INTO causes (title) VALUES
('Education Fund'),
('Health Care Initiative'),
('Environmental Protection');

INSERT INTO donations (donor_id, cause_id, amount, donated_at) VALUES
(1, 1, 100.00, '2025-08-01'),
(2, 1, 150.00, '2025-08-02'),
(3, 2, 200.00, '2025-08-03'),
(1, 3, 250.00, '2025-08-04'),
(2, 2, 300.00, '2025-08-05');

SELECT cause_id, SUM(amount) AS total_donations
FROM donations
GROUP BY cause_id
ORDER BY total_donations DESC;
