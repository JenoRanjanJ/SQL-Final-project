CREATE DATABASE course_progress_db;
USE course_progress_db;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE lessons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE progress (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    completed_at DATETIME,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (lesson_id) REFERENCES lessons(id)
);

INSERT INTO courses (name) VALUES
('Python Basics'),
('Web Development');

INSERT INTO lessons (course_id, title) VALUES
(1, 'Introduction to Python'),
(1, 'Data Types and Variables'),
(1, 'Control Structures'),
(2, 'HTML Basics'),
(2, 'CSS Styling');

INSERT INTO students (name) VALUES
('John Doe'),
('Jane Smith');

INSERT INTO progress (student_id, lesson_id, completed_at) VALUES
(1, 1, NOW()),
(1, 2, NOW()),
(2, 4, NOW());

SELECT s.name AS student,
       c.name AS course,
       COUNT(p.lesson_id) / COUNT(l.id) * 100 AS completion_percentage
FROM students s
JOIN progress p ON s.id = p.student_id
JOIN lessons l ON p.lesson_id = l.id
JOIN courses c ON l.course_id = c.id
GROUP BY s.id, c.id;
