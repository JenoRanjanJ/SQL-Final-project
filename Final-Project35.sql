CREATE DATABASE survey_collection_db;
USE survey_collection_db;

CREATE TABLE surveys (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    survey_id INT NOT NULL,
    question_text VARCHAR(500) NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES surveys(id)
);

CREATE TABLE responses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO surveys (title) VALUES
('Customer Satisfaction Survey'),
('Product Feedback Survey');

INSERT INTO questions (survey_id, question_text) VALUES
(1, 'How satisfied are you with our service?'),
(1, 'Would you recommend us to others?'),
(2, 'How do you rate the product quality?'),
(2, 'Any suggestions for improvement?');

INSERT INTO responses (user_id, question_id, answer_text) VALUES
(1, 1, 'Very Satisfied'),
(1, 2, 'Yes'),
(2, 1, 'Satisfied'),
(2, 2, 'Yes'),
(3, 1, 'Neutral'),
(3, 2, 'No'),
(1, 3, 'Excellent'),
(1, 4, 'None'),
(2, 3, 'Good'),
(2, 4, 'Add more colors');

SELECT q.question_text, r.answer_text, COUNT(*) AS total_responses
FROM responses r
JOIN questions q ON r.question_id = q.id
WHERE q.survey_id = 1
GROUP BY q.question_text, r.answer_text;

SELECT q.question_text,
       SUM(CASE WHEN r.answer_text = 'Very Satisfied' THEN 1 ELSE 0 END) AS Very_Satisfied,
       SUM(CASE WHEN r.answer_text = 'Satisfied' THEN 1 ELSE 0 END) AS Satisfied,
       SUM(CASE WHEN r.answer_text = 'Neutral' THEN 1 ELSE 0 END) AS Neutral,
       SUM(CASE WHEN r.answer_text = 'No' THEN 1 ELSE 0 END) AS No_Responses
FROM questions q
LEFT JOIN responses r ON q.id = r.question_id
WHERE q.survey_id = 1
GROUP BY q.id, q.question_text;
