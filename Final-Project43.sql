CREATE DATABASE product_return_db2;
USE product_return_db2;

-- Orders Table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT
);

-- Returns Table
CREATE TABLE returns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    reason VARCHAR(255),
    status ENUM('Pending', 'Approved', 'Rejected'),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Sample Orders
INSERT INTO orders (user_id, product_id) VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105),
(6, 106),
(7, 107),
(8, 108),
(9, 109),
(10, 110);

-- Sample Returns
INSERT INTO returns (order_id, reason, status) VALUES
(1, 'Damaged on arrival', 'Pending'),
(3, 'Wrong size', 'Approved'),
(5, 'Defective item', 'Rejected'),
(7, 'Wrong product delivered', 'Pending'),
(9, 'Changed my mind', 'Approved');
