SELECT e.last_name, a.clock_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE a.date = '2025.10.01'
  AND a.clock_in > (SELECT start_time FROM work_schedules WHERE employee_id = e.employee_id);

SELECT e.last_name, ad.start_date, ad.end_date
FROM employees e
JOIN absence_documents ad ON e.employee_id = ad.employee_id
WHERE ad.absence_type = 'vacation'
AND '2025.10.09' BETWEEN ad.start_date AND ad.end_date;

SELECT 'absence_documents' AS table_name, COUNT(*) AS row_count FROM absence_documents UNION ALL
SELECT 'attendance_records', COUNT(*) FROM attendance_records UNION ALL
SELECT 'employees', COUNT(*) FROM employees UNION ALL
SELECT 'timesheets', COUNT(*) FROM timesheets UNION ALL
SELECT 'users', COUNT(*) FROM users UNION ALL
SELECT 'work schedules', COUNT(*) FROM work_schedules;

SELECT
     e.last_name, e.first_name,
     COUNT(*) AS Late_count,
     SUM(ar.late_minutes) AS total_late_minutes
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
WHERE ar.late_minutes > 0
       AND ar.date >= '2025-10-01'
GROUP BY e.employee_id, e.last_name, e.first_name
ORDER BY total_late_minutes DESC;



