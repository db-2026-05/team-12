-- ================================================================
-- SQL DML TEMPLATE (TOPIC 09)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) INSERT scripts for all required tables in your database.
-- 2) At least 10 records per table with meaningful, realistic values.
-- 3) UPDATE / DELETE scripts where they are relevant to business logic.
-- 4) If UPDATE / DELETE are not relevant for a table, add a short note
--    in documentation explaining why.
-- 5) Comments by section so the script is easy to read and run.
--
-- SCRIPT GOALS:
-- - Populate the database with usable test data.
-- - Validate constraints through realistic DML scenarios.
-- - Support the core functionality of your application.
--
-- RECOMMENDED ORDER:
-- 1) Reference data (lookups/dictionaries)
-- 2) Core entities
-- 3) Transactional data
-- 4) Optional UPDATE / DELETE checks
--
-- IMPORTANT:
-- - Use anonymized or privacy-safe sample data where possible.
-- - The script must execute in PostgreSQL.
-- - Submit this as one SQL file.
-- ================================================================

-- Add your DML below this line
INSERT INTO classes (class_id, class_name) VALUES 
(1, 'Cycling'), (2, 'Cross-Fit'), (3, 'Pilates'),

(4, 'Stretching'), (5, 'Running'), (6, 'Box'),

(7, 'Hard BDSM'), (8, 'Yoga'), (9, 'Full-body'),

(10, 'Swimming');

SELECT *
FROM classes;

INSERT INTO training_groups 
SELECT class_id, class_name
FROM classes;

UPDATE training_groups
SET max_members = 10;

UPDATE training_groups
SET max_members = 4
WHERE group_id = 10;

UPDATE training_groups
SET max_members = 2
WHERE group_id = 7;

UPDATE training_groups
SET max_members = 8
WHERE group_id = 6;

INSERT INTO training_groups
VALUES (11, 'Box adults', 8);

UPDATE training_groups
SET name = 'Box children'
WHERE group_id = 6;

INSERT INTO schedule (schedule_id, class_id, group_id, starts_at, ends_at) VALUES

(1, 1, 1, '2026-06-01 08:00:00', '2026-06-01 09:00:00'),   
(2, 2, 2, '2026-06-01 09:30:00', '2026-06-01 10:30:00'),   
(3, 6, 6, '2026-06-01 16:00:00', '2026-06-01 17:00:00'),   
(4, 6, 11, '2026-06-01 18:30:00', '2026-06-01 20:00:00'),  

(5, 8, 8, '2026-06-02 08:30:00', '2026-06-02 09:45:00'),   
(6, 3, 3, '2026-06-02 10:00:00', '2026-06-02 11:00:00'),   
(7, 4, 4, '2026-06-02 17:00:00', '2026-06-02 18:00:00'),   
(8, 7, 7, '2026-06-02 20:00:00', '2026-06-02 21:30:00'),   

(9, 5, 5, '2026-06-03 07:30:00', '2026-06-03 08:30:00'),   
(10, 10, 10, '2026-06-03 11:00:00', '2026-06-03 11:45:00'),
(11, 9, 9, '2026-06-03 19:00:00', '2026-06-03 20:15:00'),  

(12, 1, 1, '2026-06-04 08:00:00', '2026-06-04 09:00:00'),  
(13, 2, 2, '2026-06-04 18:30:00', '2026-06-04 19:30:00'),  
(14, 3, 3, '2026-06-04 19:45:00', '2026-06-04 20:45:00'),  

(15, 10, 10, '2026-06-05 15:00:00', '2026-06-05 16:00:00');

INSERT INTO attendance (schedule_id, member_id, status) VALUES

(1, 1, 'present'), (1, 5, 'present'), (1, 6, 'present'), (1, 7, 'absent'),

(2, 5, 'present'), (2, 8, 'present'), (2, 9, 'present'),

(3, 1, 'present'), (3, 7, 'present'), (3, 10, 'absent'),

(4, 6, 'present'), (4, 11, 'present'), (4, 12, 'present'), (4, 13, 'present'),

(5, 8, 'present'), (5, 9, 'present'), (5, 11, 'present'), (5, 12, 'absent'),

(6, 6, 'present'), (6, 10, 'present'), (6, 13, 'present'),

(7, 1, 'present'), (7, 7, 'present'), (7, 9, 'present'),

(8, 5, 'present'), (8, 6, 'present'), 

(9, 1, 'present'), (9, 12, 'present'), (9, 13, 'absent'),

(10, 7, 'present'), (10, 10, 'present'), (10, 11, 'present'), (10, 1, 'absent'),

(11, 8, 'present'), (11, 9, 'present'), (11, 12, 'present'),

(12, 1, 'present'), (12, 5, 'present'), (12, 6, 'absent'),

(13, 5, 'present'), (13, 11, 'present'), (13, 13, 'present'),

(14, 6, 'present'), (14, 10, 'present'), (14, 7, 'absent'),

(15, 10, 'present'), (15, 11, 'present'), (15, 12, 'absent');

