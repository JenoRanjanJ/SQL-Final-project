CREATE DATABASE restaurant_reservation_db2;
USE restaurant_reservation_db2;

CREATE TABLE tables (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_number INT,
    capacity INT
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    table_id INT,
    date DATE,
    time_slot VARCHAR(50),
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (table_id) REFERENCES tables(id)
);

INSERT INTO tables (table_number, capacity) VALUES
(1, 2),
(2, 4),
(3, 4),
(4, 6),
(5, 8);

INSERT INTO guests (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Brown'),
('Michael Johnson'),
('Emma Davis');

INSERT INTO reservations (guest_id, table_id, date, time_slot) VALUES
(1, 1, '2025-08-12', '18:00-19:00'),
(2, 2, '2025-08-12', '19:00-20:00'),
(3, 3, '2025-08-12', '18:30-19:30'),
(4, 4, '2025-08-13', '20:00-21:00'),
(5, 5, '2025-08-13', '18:00-19:00'),
(1, 2, '2025-08-14', '19:00-20:00'),
(3, 4, '2025-08-14', '18:00-19:00'),
(2, 5, '2025-08-15', '20:00-21:00'),
(4, 1, '2025-08-15', '18:00-19:00'),
(5, 3, '2025-08-15', '19:00-20:00');
