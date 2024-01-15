-- Insert данних в таблицю Father
INSERT INTO Father (father_id, full_name, dob, phone_number) VALUES
	(21, 'Білик Дмитро Олегович', '1980-01-22', '0672267843'),
	(22,'Бондар Олег Олегович', '1981-02-22', '0631293678');

-- Insert данних в таблицю Mother
INSERT INTO Mother (mother_id, full_name, dob, phone_number) VALUES
	(21, 'Білик Марина Олегівна', '1985-01-12', '0985567811'),
	(22,'Бондар Ірина Олегівна', '1980-02-02', '0660133277');

-- Insert данних в таблицю ChildGroup
INSERT INTO ChildGroup (namegroup, age_category) VALUES
('Малята', '3'),
('Море', '4');

-- Insert данних в таблицю Child
INSERT INTO `Child` (full_name, dob, address, father_id, mother_id, group_id, age, last_attendance_date, last_arrival_time, last_departure_time) VALUES 
('Білик Марина Дмитрівна', '2020-09-10', 'вул.Економічна, буд.32, кв.55', '21', '21', '21','3','2023-12-30','8:22','16:45'),
('Бондар Іванна Олегівна', '2020-10-10', 'вул.Економічна, буд.14, кв.25', '22', '22', '21','3','2023-12-30','8:15','17:39');

-- Insert данних в таблицю Educator
INSERT INTO Educator (full_name, group_id) VALUES
('Очерет Анна Вікторівна', '1'),
('Мазур Олена Вікторівна', '2');

--  Insert данних в таблицю Event
INSERT INTO Event(group_id, nameevent, date_of_event) VALUES 
('1', 'Миколайко', '2023-12-06'),
('2', 'Миколайко', '2023-12-06');

-- Insert данних в таблицю Meal
INSERT INTO `Meal` (`group_id`, `date_of_meal`, `first_dish`, `second_dish`) VALUES
('14', '2023-12-30', 'Суп гречаний', 'Піца гавайська'),
('15', '2023-12-30', 'Ухаз червоною рибою', 'Вареники з картоплею');


-- Insert данних в таблицю MedicalWorker
INSERT INTO `MedicalWorker` (`full_name`) VALUES
('Бойкович Інна Миколаївна'),
('Гринько Олександр Михайлович');


-- Insert данних в таблицю MedicalRecord
INSERT INTO `MedicalRecord` (`child_id`, `medical_worker_id`, `date_of_record`, `health_status`) VALUES
('11', '1', '2023-12-30', 'Fair'),
('12', '6', '2023-12-30', 'Good');

-- Insert в таблицю Attendance
INSERT INTO Attendance (`child_id`, `date_of_attendance`, `time_arrival`, `time_departure`) VALUES 
('11', '2023-12-30', '08:02', '16:00'),
('12', '2023-12-30', '08:15', '16:15');
