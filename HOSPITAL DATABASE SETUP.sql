DROP DATABASE IF EXISTS hospital_management;


CREATE DATABASE hospital_management;
USE hospital_management;


CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    blood_group VARCHAR(5) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    CHECK (status IN ('Active', 'Inactive'))
);


    CREATE TABLE doctors (
        doctor_id INT PRIMARY KEY,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        specialization VARCHAR(60) NOT NULL,
        consultation_fee DECIMAL(8,2) NOT NULL,
        CHECK (consultation_fee > 0)
    );


CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason VARCHAR(150) NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


CREATE TABLE medical_records (
    record_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    record_date DATE NOT NULL,
    diagnosis VARCHAR(150) NOT NULL,
    treatment VARCHAR(200) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


INSERT INTO patients
(patient_id, first_name, last_name, email, date_of_birth, blood_group, status)
VALUES
(1, 'Oliver', 'Carter', 'oliver.carter@example.com', '2004-03-14', 'A+', 'Active'),
(2, 'Emma', 'Wilson', 'emma.wilson@example.com', '1998-07-21', 'B+', 'Active'),
(3, 'Noah', 'Bennett', 'noah.bennett@example.com', '2001-01-10', 'O+', 'Active'),
(4, 'Olivia', 'Mitchell', 'olivia.mitchell@example.com', '1995-11-05', 'AB+', 'Active'),
(5, 'Ethan', 'Parker', 'ethan.parker@example.com', '1989-04-18', 'O-', 'Active'),
(6, 'Sophia', 'Turner', 'sophia.turner@example.com', '2000-09-12', 'A-', 'Active'),
(7, 'Lucas', 'Anderson', 'lucas.anderson@example.com', '1992-06-25', 'B-', 'Active'),
(8, 'Ava', 'Morgan', 'ava.morgan@example.com', '1997-03-30', 'A+', 'Active'),
(9, 'James', 'Cooper', 'james.cooper@example.com', '1985-08-16', 'O+', 'Active'),
(10, 'Isabella', 'Reed', 'isabella.reed@example.com', '1990-12-09', 'AB-', 'Inactive');


INSERT INTO doctors
(doctor_id, first_name, last_name, email, specialization, consultation_fee)
VALUES
(1, 'William', 'Harris', 'william.harris@hospital.com', 'Cardiology', 80.00),
(2, 'Emily', 'Robinson', 'emily.robinson@hospital.com', 'Dermatology', 65.00),
(3, 'Daniel', 'Clark', 'daniel.clark@hospital.com', 'Neurology', 90.00),
(4, 'Sarah', 'Lewis', 'sarah.lewis@hospital.com', 'Pediatrics', 60.00),
(5, 'Michael', 'Walker', 'michael.walker@hospital.com', 'Orthopedics', 75.00),
(6, 'Jessica', 'Hall', 'jessica.hall@hospital.com', 'Gynecology', 70.00),
(7, 'Thomas', 'Young', 'thomas.young@hospital.com', 'General Medicine', 50.00),
(8, 'Laura', 'King', 'laura.king@hospital.com', 'Ophthalmology', 55.00),
(9, 'Robert', 'Scott', 'robert.scott@hospital.com', 'ENT', 60.00),
(10, 'Anna', 'Green', 'anna.green@hospital.com', 'Psychiatry', 85.00);


INSERT INTO appointments
(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason, status)
VALUES
(1, 1, 1, '2026-08-01', '09:00:00', 'Chest discomfort', 'Completed'),
(2, 2, 2, '2026-08-02', '10:30:00', 'Skin irritation', 'Completed'),
(3, 3, 3, '2026-08-03', '11:00:00', 'Frequent headaches', 'Completed'),
(4, 4, 5, '2026-08-04', '14:00:00', 'Knee pain', 'Completed'),
(5, 5, 7, '2026-08-05', '09:30:00', 'Routine checkup', 'Completed'),
(6, 6, 4, '2026-08-06', '13:00:00', 'Child health check', 'Completed'),
(7, 7, 8, '2026-08-07', '15:30:00', 'Blurred vision', 'Scheduled'),
(8, 8, 9, '2026-08-08', '10:00:00', 'Ear pain', 'Scheduled'),
(9, 9, 1, '2026-08-09', '12:00:00', 'High blood pressure', 'Completed'),
(10, 10, 10, '2026-08-10', '16:00:00', 'Sleep problems', 'Cancelled');


INSERT INTO medical_records
(record_id, patient_id, doctor_id, record_date, diagnosis, treatment)
VALUES
(1, 1, 1, '2026-08-01', 'Mild hypertension', 'Blood pressure monitoring'),
(2, 2, 2, '2026-08-02', 'Skin allergy', 'Antihistamine and skin cream'),
(3, 3, 3, '2026-08-03', 'Migraine', 'Rest and prescribed medication'),
(4, 4, 5, '2026-08-04', 'Knee strain', 'Physiotherapy and rest'),
(5, 5, 7, '2026-08-05', 'Vitamin deficiency', 'Dietary supplements'),
(6, 6, 4, '2026-08-06', 'Routine examination', 'No major treatment required'),
(7, 7, 8, '2026-08-07', 'Vision difficulty', 'Eye examination and glasses'),
(8, 8, 9, '2026-08-08', 'Ear infection', 'Prescribed antibiotics'),
(9, 9, 1, '2026-08-09', 'Hypertension', 'Medication and regular monitoring'),
(10, 10, 10, '2026-08-10', 'Insomnia', 'Sleep management advice');


-- 1. Basic retrieval
SELECT *
FROM patients
WHERE status = 'Active'
ORDER BY last_name ASC
LIMIT 5;


-- 2. Aggregate function with GROUP BY and HAVING
SELECT
    doctor_id,
    COUNT(*) AS total_appointments,
    AVG(
        CASE
            WHEN status = 'Completed' THEN 1
            ELSE 0
        END
    ) * 100 AS completion_rate
FROM appointments
GROUP BY doctor_id
HAVING COUNT(*) >= 1
ORDER BY completion_rate DESC;


-- 3. Subquery
SELECT
    doctor_id,
    first_name,
    last_name,
    consultation_fee
FROM doctors
WHERE consultation_fee > (
    SELECT AVG(consultation_fee)
    FROM doctors
)
ORDER BY consultation_fee DESC;




-- 4. UPDATE
UPDATE appointments
SET status = 'Completed'
WHERE appointment_id = 7;

SELECT *
FROM appointments
WHERE appointment_id = 7;


-- 5. DELETE
DELETE FROM appointments
WHERE appointment_id = 10;

SELECT *
FROM appointments
WHERE appointment_id = 10;


---------DIPSOM------