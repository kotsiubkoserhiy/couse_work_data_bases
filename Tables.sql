CREATE DATABASE KindergartenDB;
USE KindergartenDB;

CREATE TABLE Father (
    father_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    dob DATE
);
select *from mother;
CREATE TABLE Mother (
    mother_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    dob DATE
);

CREATE TABLE Educator (
    educator_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    group_id INT UNIQUE,
    FOREIGN KEY (group_id) REFERENCES ChildGroup(group_id)
);

CREATE TABLE ChildGroup (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    namegroup VARCHAR(255) NOT NULL,
    age_category VARCHAR(255),
    educator_id INT,
    FOREIGN KEY (educator_id) REFERENCES Educator(educator_id)
);

CREATE TABLE Child (
    child_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    dob DATE,
    address VARCHAR(255),
    father_id INT,
    mother_id INT,
    group_id INT,
    FOREIGN KEY (father_id) REFERENCES Father(father_id),
    FOREIGN KEY (mother_id) REFERENCES Mother(mother_id),
    FOREIGN KEY (group_id) REFERENCES ChildGroup(group_id)
);

CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT,
    date_of_attendance DATE,
    time_arrival TIME,
    time_departure TIME,
    FOREIGN KEY (child_id) REFERENCES Child(child_id)
);

CREATE TABLE MedicalWorker (
    medical_worker_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL
);

CREATE TABLE MedicalRecord (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT,
    medical_worker_id INT,
    date_of_record DATE,
    health_status VARCHAR (255),
    FOREIGN KEY (child_id) REFERENCES Child(child_id),
    FOREIGN KEY (medical_worker_id) REFERENCES MedicalWorker(medical_worker_id)
);

CREATE TABLE Meal (
    meal_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT,
    date_of_meal DATE,
    first_dish VARCHAR(255),
    second_dish VARCHAR(255),
    FOREIGN KEY (group_id) REFERENCES ChildGroup(group_id)
);

CREATE TABLE Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT,
    nameevent VARCHAR(255) NOT NULL,
    date_of_event DATE,
    FOREIGN KEY (group_id) REFERENCES ChildGroup(group_id)
);