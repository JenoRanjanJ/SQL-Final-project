CREATE DATABASE job_scheduling_db3;
USE job_scheduling_db3;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    frequency VARCHAR(50) NOT NULL
);

CREATE TABLE job_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    run_time DATETIME NOT NULL,
    status ENUM('success', 'failed', 'running') NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);

INSERT INTO jobs (name, frequency) VALUES
('Database Backup', 'daily'),
('Email Notification Sender', 'hourly'),
('Cache Cleaner', 'daily'),
('Report Generator', 'weekly');

INSERT INTO job_logs (job_id, run_time, status) VALUES
(1, '2025-08-09 23:00:00', 'success'),
(1, '2025-08-08 23:00:00', 'success'),
(2, '2025-08-10 16:00:00', 'failed'),
(2, '2025-08-10 15:00:00', 'success'),
(3, '2025-08-09 00:00:00', 'success'),
(4, '2025-08-08 08:00:00', 'running');

SELECT j.id, j.name, MAX(l.run_time) AS last_run,
CASE 
    WHEN j.frequency = 'daily' THEN DATE_ADD(MAX(l.run_time), INTERVAL 1 DAY)
    WHEN j.frequency = 'hourly' THEN DATE_ADD(MAX(l.run_time), INTERVAL 1 HOUR)
    WHEN j.frequency = 'weekly' THEN DATE_ADD(MAX(l.run_time), INTERVAL 1 WEEK)
END AS next_run
FROM jobs j
JOIN job_logs l ON j.id = l.job_id
GROUP BY j.id, j.name, j.frequency;

SELECT j.id, j.name, l.status, COUNT(*) AS status_count
FROM jobs j
JOIN job_logs l ON j.id = l.job_id
GROUP BY j.id, j.name, l.status;
