CREATE DATABASE multi_tenant_saas_db3;
USE multi_tenant_saas_db3;

CREATE TABLE tenants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    tenant_id INT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

CREATE TABLE data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tenant_id INT NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

INSERT INTO tenants (name) VALUES
('Tenant A'),
('Tenant B'),
('Tenant C');

INSERT INTO users (name, tenant_id) VALUES
('Alice', 1),
('Bob', 1),
('Charlie', 2),
('David', 3);

INSERT INTO data (tenant_id, content) VALUES
(1, 'Data for Tenant A - record 1'),
(1, 'Data for Tenant A - record 2'),
(2, 'Data for Tenant B - record 1'),
(3, 'Data for Tenant C - record 1');

SELECT u.id, u.name, t.name AS tenant_name
FROM users u
JOIN tenants t ON u.tenant_id = t.id
WHERE t.id = 1;

SELECT d.id, d.content
FROM data d
WHERE d.tenant_id = 2;
