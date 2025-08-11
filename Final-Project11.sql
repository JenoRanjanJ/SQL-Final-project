CREATE DATABASE course_enrollment_db;
USE course_enrollment_db;

CREATE TABLE courses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  instructor VARCHAR(255) NOT NULL
);

CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE enrollments (
  course_id INT NOT NULL,
  student_id INT NOT NULL,
  enroll_date DATE NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (course_id, student_id),
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO courses (title, instructor) VALUES
('Introduction to SQL', 'Dr. Anita Rao'),
('Web Development Basics', 'Mr. Rohit Kumar'),
('Data Structures', 'Prof. Maya Singh');

INSERT INTO students (name, email) VALUES
('Asha Patel', 'asha.patel@example.com'),
('Ravi Menon', 'ravi.menon@example.com'),
('Sneha Gupta', 'sneha.gupta@example.com'),
('Karan Shah', 'karan.shah@example.com');

INSERT INTO enrollments (course_id, student_id, enroll_date) VALUES
(1, 1, '2025-07-01'),
(1, 2, '2025-07-02'),
(2, 2, '2025-07-03'),
(2, 3, '2025-07-04'),
(3, 1, '2025-07-05'),
(3, 4, '2025-07-06');

SELECT c.id AS course_id, c.title AS course_title, s.id AS student_id, s.name AS student_name, e.enroll_date
FROM courses c
JOIN enrollments e ON c.id = e.course_id
JOIN students s ON s.id = e.student_id
ORDER BY c.id, e.enroll_date;

SELECT c.id AS course_id, c.title AS course_title, COUNT(e.student_id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY enrolled_students DESC;

SELECT s.id AS student_id, s.name AS student_name, GROUP_CONCAT(c.title ORDER BY c.id SEPARATOR ', ') AS courses_enrolled
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
LEFT JOIN courses c ON c.id = e.course_id
GROUP BY s.id, s.name;

CREATE INDEX idx_enrollments_course ON enrollments(course_id);
CREATE INDEX idx_enrollments_student ON enrollments(student_id);
