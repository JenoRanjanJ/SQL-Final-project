CREATE DATABASE invoice_generator_db;
USE invoice_generator_db;

CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date DATE,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE invoice_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT,
    description VARCHAR(255),
    quantity INT,
    rate DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);
