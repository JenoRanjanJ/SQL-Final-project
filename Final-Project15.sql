CREATE DATABASE health_records_db;
USE health_records_db;

CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE prescriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE medications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE prescription_details (
    prescription_id INT,
    medication_id INT,
    dosage VARCHAR(50),
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
    FOREIGN KEY (medication_id) REFERENCES medications(id)
);
