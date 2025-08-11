CREATE DATABASE online_exam_db;
USE online_exam_db;

CREATE TABLE exams (
  id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT NOT NULL,
  date DATE NOT NULL
);

CREATE TABLE questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  exam_id INT NOT NULL,
  text VARCHAR(500) NOT NULL,
  correct_option CHAR(1) NOT NULL,
  FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE student_answers (
  student_id INT NOT NULL,
  question_id INT NOT NULL,
  selected_option CHAR(1) NOT NULL,
  PRIMARY KEY (student_id, question_id),
  FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO exams (course_id, date) VALUES
(101, '2025-08-01'),
(102, '2025-08-02');

INSERT INTO questions (exam_id, text, correct_option) VALUES
(1, 'What is SQL?', 'A'),
(1, 'Which command is used to delete data?', 'B'),
(2, 'What is HTML used for?', 'C'),
(2, 'Which tag is used for a hyperlink?', 'D');

INSERT INTO student_answers (student_id, question_id, selected_option) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(1, 3, 'C'),
(1, 4, 'D'),
(2, 1, 'A'),
(2, 2, 'A'),
(2, 3, 'C'),
(2, 4, 'B');

SELECT e.id AS exam_id, e.course_id, e.date, q.id AS question_id, q.text, sa.student_id, sa.selected_option, q.correct_option
FROM exams e
JOIN questions q ON e.id = q.exam_id
JOIN student_answers sa ON sa.question_id = q.id
ORDER BY e.id, sa.student_id, q.id;

SELECT sa.student_id, e.id AS exam_id, SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) AS score
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN exams e ON q.exam_id = e.id
GROUP BY sa.student_id, e.id
ORDER BY sa.student_id, e.id;

CREATE INDEX idx_questions_exam ON questions(exam_id);
CREATE INDEX idx_student_answers_question ON student_answers(question_id);
