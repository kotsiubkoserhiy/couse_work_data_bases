-- 1 Вибрати всіх дітей з конкретної групи
SELECT Child.*, ChildGroup.namegroup
FROM Child
JOIN ChildGroup ON Child.group_id = ChildGroup.group_id
WHERE Child.group_id = 1;
-- 2 Вибрати повні імена всіх вихователів
SELECT Educator.full_name FROM Educator;
-- 3 Отримати список груп з віковими категоріями
SELECT ChildGroup.namegroup, ChildGroup.age_category FROM ChildGroup;
-- 4 Отримати список дітей та їх дати народження:
SELECT Child.full_name, Child.dob FROM Child;
-- 5 Знайти дітей, які відвідували садок сьогодні
SELECT c.full_name FROM Attendance a JOIN Child c ON a.child_id = c.child_id WHERE date_of_attendance = CURDATE();
-- 6 Вибрати дітей та їх батьків
SELECT c.full_name AS child_name, f.full_name AS father_name, m.full_name AS mother_name FROM Child c JOIN Father f ON c.father_id = f.father_id JOIN Mother m ON c.mother_id = m.mother_id;
-- 7 Отримати інформацію про останній медичний огляд для кожної дитини
SELECT c.full_name, MAX(mr.date_of_record) AS last_checkup FROM Child c JOIN MedicalRecord mr ON c.child_id = mr.child_id GROUP BY c.child_id;
-- 8 Вибрати події, заплановані для конкретної групи
SELECT Event.nameevent, Event.date_of_event
FROM Event
JOIN ChildGroup ON Event.group_id = ChildGroup.group_id
WHERE ChildGroup.group_id = 2;
-- 9 Перелічити всі страви, що подавались у певну дату
SELECT Meal.first_dish, Meal.second_dish
FROM Meal
WHERE Meal.date_of_meal = '2023-12-08';
-- 10 Знайти вихователя за ім'ям
SELECT Educator.*
FROM Educator
WHERE Educator.full_name LIKE '%Юлія%';
-- 11 Показати кількість дітей в кожній віковій категорії
SELECT ChildGroup.age_category, COUNT(Child.child_id) AS number_of_children
FROM Child
JOIN ChildGroup ON Child.group_id = ChildGroup.group_id
GROUP BY ChildGroup.age_category;
-- 12 Отримати перелік дітей без вказаної адреси
SELECT full_name FROM Child WHERE address IS NULL OR address = '';
-- 13 Вибрати імена вихователів, що мають найбільшу кількість дітей у своїх групах
SELECT e.full_name, 
       (SELECT COUNT(*) 
        FROM Child c 
        WHERE c.group_id = e.group_id) AS total_children
FROM Educator e
ORDER BY total_children DESC
LIMIT 1;
-- 14 Вибрати всіх дітей, чиї вихователі мають прізвище, що починається на "М":
SELECT c.full_name
FROM Child c
WHERE c.group_id IN (
	SELECT group_id
    FROM Educator
    WHERE full_name LIKE 'М%'
);
-- 15 Отримати список дітей, які належать до групи, що має події заплановані на майбутнє
SELECT c.full_name, cg.namegroup 
FROM Child c
JOIN ChildGroup cg ON c.group_id = cg.group_id
WHERE cg.group_id IN (
    SELECT group_id 
    FROM Event 
    WHERE date_of_event >= CURDATE()
);
-- 16 Вибрати групи без подій за останній рік
SELECT cg.namegroup 
FROM ChildGroup cg
WHERE NOT EXISTS (
    SELECT 1 
    FROM Event e
    WHERE e.group_id = cg.group_id AND e.date_of_event >= CURDATE() - INTERVAL 1 YEAR
);
-- 17 Показати імена батьків, які мають більше однієї дитини в садку
SELECT f.full_name AS father_name, m.full_name AS mother_name 
FROM Father f 
JOIN Child c1 ON f.father_id = c1.father_id 
JOIN Mother m ON c1.mother_id = m.mother_id
GROUP BY f.father_id, m.mother_id  
HAVING COUNT(c1.child_id) > 1;
-- 18 Вибрати групи, де вихователі мають прізвище починаючи на "К"
SELECT cg.namegroup 
FROM ChildGroup cg 
JOIN Educator e ON cg.group_id = e.group_id 
WHERE e.full_name LIKE 'К%';
-- 19 Показати графік приходу та відходу дітей за конкретний день
SELECT c.full_name, a.time_arrival, a.time_departure 
FROM Attendance a 
JOIN Child c ON a.child_id = c.child_id 
WHERE a.date_of_attendance = '2023-12-21';
-- 20 Отримати перелік всіх дітей, які належать до групи без вихователя
SELECT c.full_name 
FROM Child c
JOIN ChildGroup cg ON c.group_id = cg.group_id
LEFT JOIN Educator e ON cg.group_id = e.group_id
WHERE e.group_id IS NULL;

-- оптимізація запитів
-- 1 Запит для вибору дітей, які відвідували садок сьогодні
-- До оптимізації 
SELECT c.full_name 
FROM Attendance a 
JOIN Child c ON a.child_id = c.child_id 
WHERE a.date_of_attendance = CURDATE();
-- Додавання індексу
CREATE INDEX idx_date_of_attendance ON Attendance(date_of_attendance);
-- Після оптимізації запит залишається таким ж
-- Оцінка оптимізації 
EXPLAIN SELECT c.full_name 
FROM Attendance a 
JOIN Child c ON a.child_id = c.child_id 
WHERE a.date_of_attendance = CURDATE();
-- 2 Запит для знаходження імен батьків, які мають більше однієї дитини в садку
-- До оптимізації
SELECT f.full_name AS father_name, m.full_name AS mother_name 
FROM Father f 
JOIN Child c1 ON f.father_id = c1.father_id 
JOIN Mother m ON c1.mother_id = m.mother_id
GROUP BY f.father_id, m.mother_id  
HAVING COUNT(c1.child_id) > 1;
-- Після оптимізації запит залишається таким ж
-- Додавання індексів
CREATE INDEX idx_child_father_id ON Child(father_id);
CREATE INDEX idx_child_mother_id ON Child(mother_id);

-- Оцінка оптимізації 
EXPLAIN SELECT f.full_name AS father_name, m.full_name AS mother_name 
FROM Father f 
JOIN Child c1 ON f.father_id = c1.father_id 
JOIN Mother m ON c1.mother_id = m.mother_id
GROUP BY f.father_id, m.mother_id  
HAVING COUNT(c1.child_id) > 1;