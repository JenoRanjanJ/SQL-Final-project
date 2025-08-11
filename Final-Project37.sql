CREATE DATABASE food_delivery_tracker_db;
USE food_delivery_tracker_db;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    user_id INT NOT NULL,
    placed_at DATETIME NOT NULL,
    delivered_at DATETIME
);

CREATE TABLE delivery_agents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE deliveries (
    order_id INT NOT NULL,
    agent_id INT NOT NULL,
    PRIMARY KEY (order_id, agent_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(id)
);

INSERT INTO orders (restaurant_id, user_id, placed_at, delivered_at) VALUES
(1, 101, '2025-08-01 12:00:00', '2025-08-01 12:30:00'),
(2, 102, '2025-08-01 13:15:00', '2025-08-01 13:50:00'),
(1, 103, '2025-08-02 14:00:00', NULL),
(3, 104, '2025-08-02 15:10:00', '2025-08-02 15:45:00');

INSERT INTO delivery_agents (name) VALUES
('David Green'),
('Sophia White'),
('Liam Brown');

INSERT INTO deliveries (order_id, agent_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3);

SELECT AVG(TIMESTAMPDIFF(MINUTE, placed_at, delivered_at)) AS avg_delivery_time_minutes
FROM orders
WHERE delivered_at IS NOT NULL;

SELECT agent_id, COUNT(*) AS deliveries_count
FROM deliveries
GROUP BY agent_id;
