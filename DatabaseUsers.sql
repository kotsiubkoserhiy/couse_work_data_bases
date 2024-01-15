-- admin
CREATE USER 'adminkingergarten'@'localhost' IDENTIFIED BY 'adminkingergarten';
GRANT ALL PRIVILEGES ON KindergartenDB.* TO 'adminkingergarten'@'localhost';

-- educator
CREATE USER 'educatoruser'@'localhost' IDENTIFIED BY 'educatoruser';
GRANT SELECT ON KindergartenDB.Father TO 'educatoruser'@'localhost';
GRANT SELECT ON KindergartenDB.Mother TO 'educatoruser'@'localhost';
GRANT SELECT ON KindergartenDB.Child TO 'educatoruser'@'localhost';
GRANT SELECT, INSERT, UPDATE ON KindergartenDB.Attendance TO 'educatoruser'@'localhost';
GRANT SELECT ON KindergartenDB.ChildGroup TO 'educatoruser'@'localhost';
GRANT SELECT ON KindergartenDB.Event TO 'educatoruser'@'localhost';

-- medicalstaff
CREATE USER 'medicalstaff'@'localhost' IDENTIFIED BY 'medicalstaff';
GRANT SELECT, INSERT, UPDATE ON KindergartenDB.MedicalRecord TO 'medicalstaff'@'localhost';
GRANT SELECT ON KindergartenDB.Child TO 'medicalstaff'@'localhost';
GRANT SELECT ON KindergartenDB.MedicalWorker TO 'medicalstaff'@'localhost';

-- kitchenstaff
CREATE USER 'kitchenstaff'@'localhost' IDENTIFIED BY 'kitchenstaff';
GRANT SELECT, INSERT, UPDATE ON KindergartenDB.Meal TO 'kitchenstaff'@'localhost';
