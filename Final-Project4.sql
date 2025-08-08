CREATE DATABASE inventory_tracking;
USE inventory_tracking;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

CREATE TABLE suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE inventory_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    supplier_id INT,
    action ENUM('IN', 'OUT') NOT NULL,
    qty INT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

INSERT INTO products (name, stock) VALUES
('Laptop', 10),
('Mouse', 50),
('Monitor', 20);

INSERT INTO suppliers (name) VALUES
('TechSupplier Inc.'),
('Gadgets Ltd.');

DELIMITER //
CREATE TRIGGER update_stock_after_insert
AFTER INSERT ON inventory_logs
FOR EACH ROW
BEGIN
    IF NEW.action = 'IN' THEN
        UPDATE products SET stock = stock + NEW.qty WHERE id = NEW.product_id;
    ELSEIF NEW.action = 'OUT' THEN
        UPDATE products SET stock = stock - NEW.qty WHERE id = NEW.product_id;
    END IF;
END;
//
DELIMITER ;

INSERT INTO inventory_logs (product_id, supplier_id, action, qty) VALUES
(1, 1, 'IN', 5),
(2, 2, 'OUT', 3);

SELECT id, name, stock,
CASE
    WHEN stock = 0 THEN 'Out of Stock'
    WHEN stock < 5 THEN 'Low Stock'
    ELSE 'In Stock'
END AS stock_status
FROM products;
