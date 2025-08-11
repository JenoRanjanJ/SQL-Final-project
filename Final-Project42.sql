CREATE DATABASE vehicle_rental_db2;
USE vehicle_rental_db2;

-- Vehicles Table
CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50),
    plate_number VARCHAR(20) UNIQUE
);

-- Customers Table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Rentals Table
CREATE TABLE rentals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    customer_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Sample Vehicles
INSERT INTO vehicles (type, plate_number) VALUES
('Car', 'KA01AB1234'),
('Bike', 'KA02CD5678'),
('Van', 'KA03EF9101'),
('Truck', 'KA04GH2345'),
('SUV', 'KA05IJ6789');

-- Sample Customers
INSERT INTO customers (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Brown'),
('Michael Johnson'),
('Emma Davis');

-- Sample Rentals
INSERT INTO rentals (vehicle_id, customer_id, start_date, end_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(2, 2, '2025-08-02', '2025-08-04'),
(3, 3, '2025-08-03', '2025-08-06'),
(4, 4, '2025-08-05', '2025-08-10'),
(5, 5, '2025-08-07', '2025-08-09'),
(1, 2, '2025-08-12', '2025-08-15'),
(3, 4, '2025-08-14', '2025-08-18'),
(2, 5, '2025-08-16', '2025-08-20'),
(4, 1, '2025-08-19', '2025-08-22'),
(5, 3, '2025-08-21', '2025-08-25');
