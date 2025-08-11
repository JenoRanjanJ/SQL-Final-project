CREATE DATABASE fitness_tracker_db2;
USE fitness_tracker_db2;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE workouts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    type VARCHAR(50)
);

CREATE TABLE workout_logs (
    user_id INT,
    workout_id INT,
    duration INT,
    log_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (workout_id) REFERENCES workouts(id)
);

INSERT INTO users (name) VALUES
('John Doe'),
('Jane Smith'),
('Mike Johnson'),
('Emily Davis'),
('Chris Brown');

INSERT INTO workouts (name, type) VALUES
('Running', 'Cardio'),
('Bench Press', 'Strength'),
('Yoga', 'Flexibility'),
('Cycling', 'Cardio'),
('Deadlift', 'Strength');

INSERT INTO workout_logs (user_id, workout_id, duration, log_date) VALUES
(1, 1, 30, '2025-08-01'),
(1, 2, 45, '2025-08-02'),
(2, 3, 60, '2025-08-03'),
(3, 1, 25, '2025-08-04'),
(2, 2, 40, '2025-08-04'),
(4, 4, 50, '2025-08-05'),
(5, 5, 55, '2025-08-06'),
(3, 3, 35, '2025-08-07'),
(1, 4, 45, '2025-08-08'),
(4, 1, 20, '2025-08-09');
