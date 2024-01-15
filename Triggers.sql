-- 1 Тригер для перевірки віку дитини при додаванні до бази (вік має бути мінімум 2 роки)
DELIMITER //
CREATE TRIGGER CheckAgeBeforeInsert
BEFORE INSERT ON Child
FOR EACH Row
BEGIN
	IF TIMESTAMPDIFF (YEAR, NEW.dob, CURDATE())<2 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Child must be at least 2 years old.';
	END IF;
END //
DELIMITER ; 

-- Спроба вставки дитини з віком менше 2 років
INSERT INTO Child (full_name, dob, address, father_id, mother_id, group_id) 
VALUES ('Дитина 1', '2023-01-01', 'Адреса 1', 1, 2, 1);

-- 2 Тригер для автоматичного оновлення віку дитини щороку
ALTER TABLE Child ADD COLUMN age INT;

DELIMITER //
CREATE TRIGGER UpdateChildAgeAnnually
BEFORE UPDATE ON Child
FOR EACH ROW
BEGIN
    SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.dob, CURDATE());
END //
DELIMITER ;

-- Оновлення дати народження дитини
UPDATE Child SET dob = '2019-05-17' WHERE child_id = 1;

select *from Child;

-- 3 Перевірка записів відвідуваності, які застаріли на більше ніж рік
DELIMITER //
CREATE TRIGGER DeleteOldAttendanceRecords
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN
    -- Перевірка і виведення повідомлення, якщо дата відвідування застаріла на 1 рік
    IF NEW.date_of_attendance < CURDATE() - INTERVAL 1 YEAR THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert attendance record older than 1 year.';
    END IF;
END //
DELIMITER ;

-- Вставка запису відвідуваності з датою за 2 роки тому
INSERT INTO Attendance (child_id, date_of_attendance, time_arrival, time_departure)
VALUES (11, '2021-01-29', '08:05', '16:10');

-- 4 Тригер для оновлення останньої відвідуваності
DELIMITER //
CREATE TRIGGER UpdateLastAttendance
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN
    UPDATE Child
    SET last_attendance_date = NEW.date_of_attendance,
        last_arrival_time = NEW.time_arrival,
        last_departure_time = NEW.time_departure
    WHERE child_id = NEW.child_id;
END //
DELIMITER ;
-- Вставка нового запису в таблицю Attendance
INSERT INTO Attendance (child_id, date_of_attendance, time_arrival, time_departure)
VALUES (1, '2023-12-22', '09:15', '17:50');
select *from Child;

-- 5 Тригер для перевірки застарілих записів в таблиці MedicalRecord
DELIMITER //
CREATE TRIGGER DeleteOldMedicalRecords
AFTER INSERT ON MedicalRecord
FOR EACH ROW
BEGIN
    -- Перевірка і виведення повідомлення, якщо дата запису застаріла на 2 роки
    IF NEW.date_of_record < CURDATE() - INTERVAL 2 YEAR THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert medical record older than 2 years.';
    END IF;
END //
DELIMITER ;
-- Вставка нового запису в таблицю MedicalRecord
INSERT INTO MedicalRecord (child_id, medical_worker_id, date_of_record, health_status)
VALUES (22, 1, '2021-01-01', 'Good');