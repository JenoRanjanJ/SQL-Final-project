CREATE DATABASE movie_db;
USE movie_db;

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE ratings (
    user_id INT,
    movie_id INT,
    score DECIMAL(2,1),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

INSERT INTO genres (name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror'),
('Sci-Fi');

INSERT INTO movies (title, release_year, genre_id) VALUES
('Inception', 2010, 5),
('The Dark Knight', 2008, 1),
('Interstellar', 2014, 5),
('The Hangover', 2009, 2),
('The Godfather', 1972, 3);

INSERT INTO ratings (user_id, movie_id, score) VALUES
(1, 1, 9.0),
(2, 1, 8.5),
(3, 1, 9.5),
(1, 2, 9.0),
(2, 2, 9.5),
(3, 2, 9.0),
(1, 3, 8.0),
(2, 3, 8.5),
(3, 3, 8.0),
(1, 4, 7.0),
(2, 4, 7.5),
(3, 4, 7.0),
(1, 5, 9.5),
(2, 5, 9.0),
(3, 5, 9.5);

SELECT m.id, m.title, m.release_year, g.name AS genre, AVG(r.score) AS avg_rating
FROM movies m
JOIN genres g ON m.genre_id = g.id
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title, m.release_year, g.name;
