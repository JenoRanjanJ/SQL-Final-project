CREATE DATABASE appointment_scheduler;
USE appointment_scheduler;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    appointment_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id),
    UNIQUE (service_id, appointment_time)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO services (name) VALUES
('Haircut'),
('Massage'),
('Consultation');

INSERT INTO appointments (user_id, service_id, appointment_time) VALUES
(1, 1, '2025-08-08 10:00:00'),
(2, 2, '2025-08-08 11:00:00'),
(3, 3, '2025-08-08 12:00:00');

SELECT * FROM appointments
WHERE DATE(appointment_time) = '2025-08-08';

SELECT * FROM appointments
WHERE service_id = 1 AND DATE(appointment_time) = '2025-08-08';
