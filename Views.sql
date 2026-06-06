CREATE VIEW vw_late_records AS
SELECT 
    CONCAT(e.last_name, ' ', e.first_name, ' ', e.patronymic) AS full_name,
    ar.date AS attendance_date,
    ar.clock_in AS actual_time,
    ws.start_time AS planned_start_time,
    ar.late_minutes,
    ar.notes
FROM 
    attendance_records ar
    INNER JOIN employees e ON ar.employee_id = e.employee_id
    INNER JOIN work_schedules ws ON ar.employee_id = ws.employee_id
WHERE 
    ar.late_minutes > 0
ORDER BY 
    ar.late_minutes DESC, ar.date DESC;

CREATE VIEW vw_late_summary AS
SELECT 
    CONCAT(e.last_name, ' ', e.first_name, ' ', e.patronymic) AS full_name,
    COUNT(ar.record_id) AS total_late_incidents,
    SUM(ar.late_minutes) AS total_late_minutes
FROM 
    attendance_records ar
    INNER JOIN employees e ON ar.employee_id = e.employee_id
WHERE 
    ar.late_minutes > 0
GROUP BY 
    e.employee_id, e.last_name, e.first_name, e.patronymic
ORDER BY 
    SUM(ar.late_minutes) DESC;

