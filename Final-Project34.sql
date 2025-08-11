CREATE DATABASE sports_tournament_db;
USE sports_tournament_db;

CREATE TABLE teams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE matches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES teams(id),
    FOREIGN KEY (team2_id) REFERENCES teams(id)
);

CREATE TABLE scores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    score INT NOT NULL,
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

INSERT INTO teams (name) VALUES
('Tigers'),
('Lions'),
('Eagles'),
('Sharks');

INSERT INTO matches (team1_id, team2_id, match_date) VALUES
(1, 2, '2025-08-05'),
(3, 4, '2025-08-06'),
(1, 3, '2025-08-08'),
(2, 4, '2025-08-09');

INSERT INTO scores (match_id, team_id, score) VALUES
(1, 1, 3),
(1, 2, 2),
(2, 3, 1),
(2, 4, 4),
(3, 1, 0),
(3, 3, 2),
(4, 2, 3),
(4, 4, 3);

SELECT t.name,
       SUM(CASE WHEN s.score > opp.score THEN 1 ELSE 0 END) AS wins,
       SUM(CASE WHEN s.score < opp.score THEN 1 ELSE 0 END) AS losses,
       SUM(CASE WHEN s.score = opp.score THEN 1 ELSE 0 END) AS draws
FROM scores s
JOIN teams t ON s.team_id = t.id
JOIN scores opp ON s.match_id = opp.match_id AND s.team_id <> opp.team_id
GROUP BY t.id
ORDER BY wins DESC, draws DESC;
