CREATE DATABASE product_wishlist_db;
USE product_wishlist_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE wishlist (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO users (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Johnson');

INSERT INTO products (name) VALUES
('Laptop'),
('Smartphone'),
('Headphones');

INSERT INTO wishlist (user_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 1);

SELECT product_id, COUNT(user_id) AS wishlist_count
FROM wishlist
GROUP BY product_id
ORDER BY wishlist_count DESC;
