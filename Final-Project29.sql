CREATE DATABASE recruitment_portal_db;
USE recruitment_portal_db;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    company VARCHAR(255) NOT NULL
);

CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE applications (
    job_id INT NOT NULL,
    candidate_id INT NOT NULL,
    status ENUM('Applied', 'Interview', 'Hired', 'Rejected') NOT NULL,
    applied_at DATETIME NOT NULL,
    PRIMARY KEY (job_id, candidate_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

INSERT INTO jobs (title, company) VALUES
('Software Engineer', 'TechCorp'),
('Data Analyst', 'DataWorks');

INSERT INTO candidates (name) VALUES
('Alice Johnson'),
('Bob Williams'),
('Charlie Brown');

INSERT INTO applications (job_id, candidate_id, status, applied_at) VALUES
(1, 1, 'Applied', NOW()),
(1, 2, 'Interview', NOW()),
(2, 3, 'Applied', NOW());

SELECT c.name AS candidate_name, j.title AS job_title, a.status
FROM applications a
JOIN candidates c ON a.candidate_id = c.id
JOIN jobs j ON a.job_id = j.id
WHERE a.status = 'Interview';

SELECT j.title AS job_title, COUNT(a.candidate_id) AS applicant_count
FROM jobs j
LEFT JOIN applications a ON j.id = a.job_id
GROUP BY j.id;
