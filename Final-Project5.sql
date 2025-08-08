CREATE DATABASE product_reviews;
USE product_reviews;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT unique_user_product_review UNIQUE (user_id, product_id)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO products (name) VALUES
('Laptop'),
('Smartphone'),
('Headphones');

INSERT INTO reviews (user_id, product_id, rating, review) VALUES
(1, 1, 4.5, 'Great performance and build quality.'),
(2, 1, 4.0, 'Solid laptop but a bit expensive.'),
(3, 2, 5.0, 'Amazing phone, very fast!'),
(1, 3, 3.5, 'Decent sound but uncomfortable.'),
(2, 3, 4.2, 'Good sound quality and comfortable.');

SELECT 
    p.id,
    p.name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.id) AS total_reviews
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name;

SELECT 
    p.id,
    p.name,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
HAVING avg_rating >= 4.5
ORDER BY avg_rating DESC;
