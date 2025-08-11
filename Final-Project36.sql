CREATE DATABASE it_support_ticket_db;
USE it_support_ticket_db;

CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    issue VARCHAR(500) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    resolved_at DATETIME
);

CREATE TABLE support_staff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE assignments (
    ticket_id INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (ticket_id, staff_id),
    FOREIGN KEY (ticket_id) REFERENCES tickets(id),
    FOREIGN KEY (staff_id) REFERENCES support_staff(id)
);

INSERT INTO tickets (user_id, issue, status, created_at, resolved_at) VALUES
(1, 'Unable to login', 'Resolved', '2025-08-01 09:15:00', '2025-08-01 10:00:00'),
(2, 'Email not syncing', 'In Progress', '2025-08-02 11:20:00', NULL),
(3, 'Printer not working', 'Resolved', '2025-08-03 14:05:00', '2025-08-03 15:45:00'),
(4, 'Software installation request', 'Open', '2025-08-04 16:30:00', NULL);

INSERT INTO support_staff (name) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Lee');

INSERT INTO assignments (ticket_id, staff_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1);

SELECT AVG(TIMESTAMPDIFF(MINUTE, created_at, resolved_at)) AS avg_resolution_time_minutes
FROM tickets
WHERE resolved_at IS NOT NULL;

SELECT issue, COUNT(*) AS ticket_count
FROM tickets
GROUP BY issue;
