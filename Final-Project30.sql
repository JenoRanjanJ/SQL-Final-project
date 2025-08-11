DROP DATABASE IF EXISTS hotel_booking_db;
CREATE DATABASE hotel_booking_db;


CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(10) NOT NULL,
    type ENUM('Single', 'Double', 'Suite') NOT NULL
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT NOT NULL,
    guest_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (guest_id) REFERENCES guests(id)
);

INSERT INTO rooms (number, type) VALUES
('101', 'Single'),
('102', 'Double'),
('201', 'Suite');

INSERT INTO guests (name) VALUES
('Alice Johnson'),
('Mark Spencer');

INSERT INTO bookings (room_id, guest_id, from_date, to_date) VALUES
(1, 1, '2025-08-01', '2025-08-03'),
(2, 2, '2025-08-05', '2025-08-07');

SELECT r.id, r.number, r.type
FROM rooms r
WHERE r.id NOT IN (
    SELECT room_id FROM bookings
    WHERE ('2025-08-02' BETWEEN from_date AND to_date)
       OR ('2025-08-04' BETWEEN from_date AND to_date)
       OR (from_date BETWEEN '2025-08-02' AND '2025-08-04')
       OR (to_date BETWEEN '2025-08-02' AND '2025-08-04')
);

SELECT r.number, g.name, b.from_date, b.to_date
FROM bookings b
JOIN rooms r ON b.room_id = r.id
JOIN guests g ON b.guest_id = g.id;
