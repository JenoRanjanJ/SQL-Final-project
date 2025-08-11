CREATE DATABASE inventory_expiry_db;
USE inventory_expiry_db;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE batches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    expiry_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO products (name) VALUES
('Milk'),
('Bread'),
('Cheese');

INSERT INTO batches (product_id, quantity, expiry_date) VALUES
(1, 50, '2025-08-05'),
(1, 30, '2025-08-15'),
(2, 20, '2025-08-08'),
(3, 15, '2025-09-01');

SELECT p.name, b.quantity, b.expiry_date
FROM batches b
JOIN products p ON b.product_id = p.id
WHERE b.expiry_date < CURDATE();

SELECT p.name, SUM(b.quantity) AS total_quantity
FROM batches b
JOIN products p ON b.product_id = p.id
WHERE b.expiry_date >= CURDATE()
GROUP BY p.name;
