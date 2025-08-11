CREATE DATABASE freelance_project_mgmt_db;
USE freelance_project_mgmt_db;

CREATE TABLE freelancers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    skill VARCHAR(100)
);

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100),
    title VARCHAR(150)
);

CREATE TABLE proposals (
    freelancer_id INT,
    project_id INT,
    bid_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

INSERT INTO freelancers (name, skill) VALUES
('Alice Johnson', 'Web Development'),
('Brian Smith', 'Graphic Design'),
('Catherine Lee', 'Content Writing'),
('David Brown', 'Mobile App Development'),
('Ella Wilson', 'SEO Specialist');

INSERT INTO projects (client_name, title) VALUES
('TechCorp', 'E-commerce Website'),
('Creative Studios', 'Brand Logo Design'),
('BlogWorld', 'Travel Blog Articles'),
('AppVentures', 'Fitness Tracker App'),
('MarketBoost', 'SEO Optimization');

INSERT INTO proposals (freelancer_id, project_id, bid_amount, status) VALUES
(1, 1, 1500.00, 'Accepted'),
(2, 2, 500.00, 'Pending'),
(3, 3, 300.00, 'Accepted'),
(4, 4, 2000.00, 'Rejected'),
(5, 5, 800.00, 'Pending'),
(1, 4, 1800.00, 'Pending'),
(2, 1, 1400.00, 'Rejected'),
(3, 5, 700.00, 'Accepted'),
(4, 2, 600.00, 'Pending'),
(5, 3, 400.00, 'Accepted');
