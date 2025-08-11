CREATE DATABASE attendance_tracker_db;
USE attendance_tracker_db;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attendance (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent') NOT NULL,
    PRIMARY KEY (student_id, course_id, date),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO students (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Johnson');

INSERT INTO courses (name) VALUES
('Mathematics'),
('Physics');

INSERT INTO attendance (student_id, course_id, date, status) VALUES
(1, 1, '2025-08-01', 'Present'),
(1, 1, '2025-08-02', 'Absent'),
(2, 2, '2025-08-01', 'Present'),
(3, 1, '2025-08-01', 'Present');

SELECT student_id, course_id, COUNT(*) AS total_classes,
SUM(status = 'Present') AS total_present
FROM attendance
GROUP BY student_id, course_id;
