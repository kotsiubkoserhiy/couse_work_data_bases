-- 1 Збережена процедура для додавання дитини
DELIMITER //
CREATE PROCEDURE AddChild (
    IN p_full_name VARCHAR(255), 
    IN p_dob DATE, 
    IN p_address VARCHAR(255), 
    IN p_father_id INT, 
    IN p_mother_id INT, 
    IN p_group_id INT,
    IN p_age INT
)
BEGIN
    INSERT INTO Child (full_name, dob, address, father_id, mother_id, group_id, age) 
    VALUES (p_full_name, p_dob, p_address, p_father_id, p_mother_id, p_group_id, p_age);
END //
DELIMITER ;
CALL AddChild('Вітюк Богдан Олександрович', '2019-01-01', 'пр.Перемоги, буд.110, кв.46', 2, 2, 3, 4);
select *from Child;

-- 2 Функція для обчислення віку дитини
DELIMITER //
CREATE FUNCTION CalculateAge (p_dob DATE) 
RETURNS INT
READS SQL DATA
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_dob, CURDATE());
END //
DELIMITER ;

SELECT CalculateAge('2019-01-01') AS Age;


-- 3 Збережена процедура для оновлення телефона батька
DELIMITER //
CREATE PROCEDURE UpdateFatherPhoneNumber (
    IN p_father_id INT, 
    IN p_new_phone_number VARCHAR(20)
)
BEGIN
    UPDATE Father SET phone_number = p_new_phone_number WHERE father_id = p_father_id;
END //
DELIMITER ;

CALL UpdateFatherPhoneNumber(1, '0552317845');

-- 4 Збережена процедура для запису відвідуваності дитини
DELIMITER //
CREATE PROCEDURE RecordAttendance (
	IN p_child_id INT, 
    IN p_date_of_attendance DATE, 
    IN p_time_arrival TIME, 
    IN p_time_departure TIME
)
BEGIN
	INSERT INTO Attendance (child_id, date_of_attendance, time_arrival, time_departure)
	VALUES (p_child_id, p_date_of_attendance, p_time_arrival, p_time_departure);
END //
DELIMITER ;

CALL RecordAttendance(1, '2023-12-22', '08:10', '17:00');

-- 5 Функція для перевірки здоров'я дитини
DELIMITER //
CREATE FUNCTION CheckHealthStatus (p_child_id INT) 
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE status VARCHAR(255);
    SELECT health_status INTO status 
    FROM MedicalRecord 
    WHERE child_id = p_child_id 
    ORDER BY date_of_record DESC 
    LIMIT 1;
    RETURN status;
END //
DELIMITER ;

SELECT CheckHealthStatus(2) AS HealthStatus;


-- 6 Збережена процедура для додавання події
DELIMITER //
CREATE PROCEDURE AddEvent (
    IN p_group_id INT, 
    IN p_nameevent VARCHAR(255), 
    IN p_date_of_event DATE
)
BEGIN
    INSERT INTO Event (group_id, nameevent, date_of_event) 
    VALUES (p_group_id, p_nameevent, p_date_of_event);
END //
DELIMITER ;
CALL AddEvent(1, 'Різдво', '2023-12-25');


-- 7 Функція для обчислення середнього віку дітей в групі
DELIMITER // 
CREATE FUNCTION AvarageAgeInGroup (p_group_id INT)
RETURNS FLOAT
READS SQL Data
BEGIN
	DECLARE avg_age FLOAT;
    SELECT AVG (TIMESTAMPDIFF(YEAR, dob, CURDATE())) INTO avg_age
    FROM Child
    WHERE group_id = p_group_id;
    RETURN avg_age;
END //
DELIMITER ;
SELECT AvarageAgeInGroup(1) AS AverageAge;

-- 8 Збережена процедура для видалення медичного запису
DELIMITER //
CREATE PROCEDURE DeleteMedicalRecord (
    IN p_record_id INT
)
BEGIN
    DELETE FROM MedicalRecord WHERE record_id = p_record_id;
END //
DELIMITER ;
CALL DeleteMedicalRecord(1);
select *from MedicalRecord;

-- 9 Збережена процедура для запису прийому їжі
DELIMITER //
CREATE PROCEDURE RecordMeal (
    IN p_group_id INT, 
    IN p_date_of_meal DATE, 
    IN p_first_dish VARCHAR(255), 
    IN p_second_dish VARCHAR(255)
)
BEGIN
    INSERT INTO Meal (group_id, date_of_meal, first_dish, second_dish) 
    VALUES (p_group_id, p_date_of_meal, p_first_dish, p_second_dish);
END //
DELIMITER ;
CALL RecordMeal(1, '2023-12-22', 'Солянка мʼясна', 'Деруни');
select *from Meal;

-- 10 Функція для розрахунку кількості дітей у групі
DELIMITER //
CREATE FUNCTION CountChildrenInGroup (p_group_id INT) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE children_count INT;
    SELECT COUNT(*) INTO children_count 
    FROM Child 
    WHERE group_id = p_group_id;
    RETURN children_count;
END //
DELIMITER ;
SELECT CountChildrenInGroup(1) AS ChildrenCount;