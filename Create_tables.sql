DROP database if EXISTS db_practica;
CREATE SCHEMA db_practica;
USE db_practica;

DROP TABLE IF EXISTS 'employees';
CREATE TABLE IF NOT EXISTS employees(
    employee_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50),
    position VARCHAR(100) NOT NULL,
    rank VARCHAR(20),
    hire_date DATE NOT NULL,
    status ENUM('active', 'on_leave', 'sick_leave') DEFAULT 'active',
    shift_type ENUM('morning', 'evening', 'night') NOT null
);
ALTER TABLE employees CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


DROP TABLE IF EXISTS 'work_schedules';
CREATE TABLE work_schedules(
    schedule_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    work_days VARCHAR(25)  NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);
ALTER TABLE work_schedules CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS 'attendance_records';
CREATE TABLE attendance_records(
    record_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    date DATE NOT NULL,
    clock_in TIMESTAMP,
    clock_out TIMESTAMP,
    late_minutes INTEGER DEFAULT 0 CHECK (late_minutes >= 0),
    early_leave_minutes INTEGER DEFAULT 0 CHECK (early_leave_minutes >= 0),
    notes TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    UNIQUE (employee_id, date)
);


ALTER TABLE attendance_records MODIFY COLUMN clock_in TIME;
ALTER TABLE attendance_records MODIFY COLUMN clock_out TIME;
ALTER TABLE attendance_records CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE absence_documents (
    document_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    absence_type ENUM('sick_leave', 'vacation', 'business_trip', 'day_off') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    issued_by VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    CHECK (end_date >= start_date)
);
ALTER TABLE absence_documents CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE timesheets (
    timesheet_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    total_hours DECIMAL(5,2) DEFAULT 0.00 CHECK (total_hours >= 0),
    overtime_hours DECIMAL(5,2) DEFAULT 0.00 CHECK (overtime_hours >= 0),
    approved_by VARCHAR(100),
    approval_date TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    CHECK (period_end >= period_start)
);
ALTER TABLE timesheets CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS 'users';
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('master', 'chief', 'accountant', 'hr', 'admin') NOT NULL,
    employee_id INTEGER,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);
ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Индексы для ускорения запросов
CREATE INDEX idx_attendance_employee_date ON attendance_records(employee_id, date);
CREATE INDEX idx_timesheets_period ON timesheets(period_start, period_end);
CREATE INDEX idx_absence_employee ON absence_documents(employee_id);
CREATE INDEX idx_schedules_employee ON work_schedules(employee_id);
CREATE INDEX idx_users_employee ON users(employee_id);

