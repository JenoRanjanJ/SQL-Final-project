CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE brands (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    image_url VARCHAR(255),
    category_id INT,
    brand_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id)
);

CREATE INDEX idx_category_id ON products(category_id);
CREATE INDEX idx_brand_id ON products(brand_id);
CREATE INDEX idx_price ON products(price);

INSERT INTO categories (name) VALUES 
('Electronics'),
('Apparel'),
('Home Appliances');

INSERT INTO brands (name) VALUES 
('Apple'),
('Nike'),
('Samsung');

INSERT INTO products (name, description, price, stock, image_url, category_id, brand_id) VALUES
('iPhone 15', 'Latest Apple smartphone', 999.99, 50, 'iphone15.jpg', 1, 1),
('Nike Air Max', 'Running shoes', 149.99, 200, 'nike_air_max.jpg', 2, 2),
('Samsung Smart TV', '55-inch 4K TV', 699.99, 30, 'samsung_tv.jpg', 1, 3);

SELECT * FROM products WHERE category_id = 1;
SELECT * FROM products WHERE brand_id = 2;
SELECT * FROM products WHERE price BETWEEN 100 AND 500;
