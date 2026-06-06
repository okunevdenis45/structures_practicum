
-- Создание пользователя и полномочия для мастера участка
CREATE USER 'master_user'@'localhost' IDENTIFIED BY 'Pass12345';
GRANT SELECT ON db_practica.employees TO 'master_user'@'localhost';
GRANT SELECT ON db_practica.work_schedules TO 'master_user'@'localhost';
GRANT SELECT ON db_practica.timesheets TO 'master_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON db_practica.attendance_records TO 'master_user'@'localhost';
GRANT INSERT ON db_practica.absence_documents TO 'master_user'@'localhost';

-- Создание пользователя и полномочия для начальника цеха
CREATE USER 'chief_user'@'localhost' IDENTIFIED BY 'Pass54321';
GRANT ALL PRIVILEGES ON db_practica.employees TO 'chief_user'@'localhost';
GRANT ALL PRIVILEGES ON db_practica.work_schedules TO 'chief_user'@'localhost';
GRANT ALL PRIVILEGES ON db_practica.attendance_records TO 'chief_user'@'localhost';
GRANT ALL PRIVILEGES ON db_practica.absence_documents TO 'chief_user'@'localhost';
GRANT ALL PRIVILEGES ON db_practica.timesheets TO 'chief_user'@'localhost';

-- Создание пользователя и полномочия для бухгалтера
CREATE USER 'accountant_user'@'localhost' IDENTIFIED BY 'Pass123456';
GRANT SELECT ON db_practica.employees TO 'accountant_user'@'localhost';
GRANT SELECT ON db_practica.timesheets TO 'accountant_user'@'localhost';

-- Создание пользователя и полномочия для сотрудника отдела кадров
CREATE USER 'hr_user'@'localhost' IDENTIFIED BY 'Pass1234567';
GRANT ALL PRIVILEGES ON db_practica.employees TO 'hr_user'@'localhost';
GRANT ALL PRIVILEGES ON db_practica.absence_documents TO 'hr_user'@'localhost';
GRANT SELECT ON db_practica.work_schedules TO 'hr_user'@'localhost';

-- Создание пользователя и полномочия для администратора
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'PassAdmin';
GRANT ALL PRIVILEGES ON db_practica.* TO 'admin_user'@'localhost';


-- Чтобы точно заработали привилегии
FLUSH PRIVILEGES;





