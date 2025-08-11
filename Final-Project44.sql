CREATE DATABASE course_feedback_db2;
USE course_feedback_db2;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255)
);

CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    user_id INT,
    rating DECIMAL(2,1),
    comments TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO courses (title) VALUES
('Introduction to Python'),
('Advanced Java'),
('Data Structures and Algorithms'),
('Web Development with HTML & CSS'),
('Machine Learning Basics');

INSERT INTO feedback (course_id, user_id, rating, comments) VALUES
(1, 101, 4.5, 'Very informative and beginner friendly'),
(1, 102, 4.0, 'Good pacing, but could have more exercises'),
(2, 103, 3.8, 'Challenging content, but rewarding'),
(3, 104, 5.0, 'Excellent explanations and examples'),
(4, 105, 4.2, 'Great for beginners, needs more advanced topics'),
(5, 106, 4.9, 'Loved the practical examples'),
(5, 107, 4.7, 'Clear and concise teaching style');
