-- 1 Представлення для перегляду детальної інформації про дітей та їхніх батьків
CREATE VIEW ChildParentDetails AS
SELECT 
    c.child_id,
    c.full_name AS child_name,
    c.dob AS child_dob,
    c.address AS child_address,
    f.full_name AS father_name,
    f.phone_number AS father_phone,
    m.full_name AS mother_name,
    m.phone_number AS mother_phone
FROM Child c
LEFT JOIN Father f ON c.father_id = f.father_id
LEFT JOIN Mother m ON c.mother_id = m.mother_id;

select *from ChildParentDetails;

-- 2 Представлення для перегляду відомостей про групи та відповідальних вихователів
CREATE VIEW GroupAndEducatorDetails AS
SELECT 
    cg.group_id, 
    cg.namegroup, 
    cg.age_category, 
    e.full_name AS educator_name
FROM ChildGroup cg
JOIN Educator e ON cg.group_id = e.group_id;

select *from GroupAndEducatorDetails;

-- 3 Представлення для останніх медичних записів кожної дитини
CREATE VIEW LatestChildMedicalRecords AS
SELECT 
    mr.child_id, 
    c.full_name AS child_name, 
    MAX(mr.date_of_record) AS latest_record_date, 
    mr.health_status, 
    mw.full_name AS medical_worker_name
FROM MedicalRecord mr
JOIN Child c ON mr.child_id = c.child_id
JOIN MedicalWorker mw ON mr.medical_worker_id = mw.medical_worker_id
GROUP BY mr.child_id, c.full_name, mr.health_status, mw.full_name;

select *from LatestChildMedicalRecords;