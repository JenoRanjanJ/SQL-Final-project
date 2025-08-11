CREATE DATABASE messaging_system_db;
USE messaging_system_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE conversations (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT NOT NULL,
    sender_id INT NOT NULL,
    message_text TEXT NOT NULL,
    sent_at DATETIME NOT NULL,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    FOREIGN KEY (sender_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO conversations () VALUES
(),
();

INSERT INTO messages (conversation_id, sender_id, message_text, sent_at) VALUES
(1, 1, 'Hey Bob, how are you?', '2025-08-09 09:00:00'),
(1, 2, 'I am good, Alice. How about you?', '2025-08-09 09:02:00'),
(2, 3, 'Hey Alice, are you free for a call?', '2025-08-09 09:05:00');

SELECT * FROM messages WHERE conversation_id = 1 ORDER BY sent_at DESC;

SELECT c.id AS conversation_id, m.message_text, m.sent_at
FROM conversations c
JOIN messages m ON c.id = m.conversation_id
WHERE m.sent_at = (
    SELECT MAX(sent_at) FROM messages WHERE conversation_id = c.id
);
