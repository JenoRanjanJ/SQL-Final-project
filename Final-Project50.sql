CREATE DATABASE event_management_db;
USE event_management_db;

CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    max_capacity INT NOT NULL
);

CREATE TABLE attendees (
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    registered_at DATETIME NOT NULL,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);

INSERT INTO events (title, max_capacity) VALUES
('Tech Conference', 100),
('Music Festival', 500),
('Startup Meetup', 50);

INSERT INTO attendees (event_id, user_id, registered_at) VALUES
(1, 101, NOW()),
(1, 102, NOW()),
(2, 201, NOW()),
(3, 301, NOW()),
(3, 302, NOW());

SELECT e.id, e.title, COUNT(a.user_id) AS participant_count
FROM events e
LEFT JOIN attendees a ON e.id = a.event_id
GROUP BY e.id, e.title;

SELECT e.id, e.title, COUNT(a.user_id) AS participant_count, e.max_capacity
FROM events e
LEFT JOIN attendees a ON e.id = a.event_id
GROUP BY e.id, e.title, e.max_capacity
HAVING participant_count >= e.max_capacity;
