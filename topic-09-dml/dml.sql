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


--- Таблица  'measurements'
create table public.measurements (
  measurement_id bigserial not null,
  member_id bigint not null,
  metric_type character varying(50) not null,
  value numeric(8, 2) not null,
  unit character varying(20) not null,
  measured_at timestamp with time zone not null default CURRENT_TIMESTAMP,
  constraint measurements_pkey primary key (measurement_id),
  constraint fk_measurements_member foreign KEY (member_id) references members (member_id)
);

INSERT INTO "public"."measurements" ("measurement_id", "member_id", "metric_type", "value", "unit", "measured_at") VALUES (1, 1, 'weight', '92.70', 'kg', '2026-06-02 18:55:28.059317+00'), (2, 1, 'body_fat', '24.00', '%', '2026-06-02 18:55:28.059317+00'), (3, 1, 'biceps', '36.00', 'cm', '2026-06-02 18:55:28.059317+00'), (7, 5, 'weight', '101.00', 'kg', '2026-06-02 18:57:16.389748+00'), (8, 5, 'body_fat', '21.00', '%', '2026-06-02 18:57:16.389748+00'), (9, 5, 'biceps', '38.40', 'cm', '2026-06-02 18:57:16.389748+00'), (10, 6, 'weight', '66.40', 'kg', '2026-06-02 18:59:12.489496+00'), (11, 6, 'body_fat', '21.00', '%', '2026-06-02 18:59:12.489496+00'), (12, 6, 'biceps', '34.00', 'cm', '2026-06-02 18:59:12.489496+00'), (13, 7, 'weight', '67.60', 'kg', '2026-06-02 19:00:46.33812+00'), (14, 7, 'body_fat', '19.00', '%', '2026-06-02 19:00:46.33812+00'), (15, 7, 'biceps', '34.70', 'cm', '2026-06-02 19:00:46.33812+00'), (16, 8, 'weight', '110.00', 'kg', '2026-06-02 19:02:00.143453+00'), (17, 8, 'body_fat', '28.00', '%', '2026-06-02 19:02:00.143453+00'), (18, 8, 'biceps', '36.00', 'cm', '2026-06-02 19:02:00.143453+00'), (19, 9, 'weight', '65.00', 'kg', '2026-06-02 19:02:48.560242+00'), (20, 9, 'body_fat', '21.00', '%', '2026-06-02 19:02:48.560242+00'), (21, 9, 'biceps', '30.00', 'cm', '2026-06-02 19:02:48.560242+00'), (22, 13, 'weight', '77.70', 'kg', '2026-06-02 19:03:52.693467+00'), (23, 13, 'body_fat', '18.00', '%', '2026-06-02 19:03:52.693467+00'), (24, 13, 'biceps', '36.70', 'cm', '2026-06-02 19:03:52.693467+00');


--- Таблица 'Members'
create table public.members (
  member_id bigserial not null,
  first_name character varying(50) not null,
  phone character varying(18) not null,
  email character varying(100) null,
  birthday date not null,
  hub_id integer null,
  last_name character varying not null,
  constraint members_pkey primary key (member_id),
  constraint members_email_key unique (email),
  constraint members_phone_key unique (phone),
  constraint members_hub_id_fkey foreign KEY (hub_id) references fitness_club (hub_id)
);

INSERT INTO "public"."members" ("member_id", "first_name", "phone", "email", "birthday", "hub_id", "last_name") VALUES (1, 'Kyrylo', '+380951930507', 'kirillsheyn221@gmail.com', '2005-08-24', 1, 'Shein'), (5, 'Roman', '+380661821232', 'loker123@gmail.com', '2000-12-11', 1, 'Golovach'), (6, 'John', '+380731442329', 'johndoe@gmail.com', '1999-09-09', 1, 'Doe'), (7, 'Vladyslav', '+380952414712', null, '2005-08-24', 1, 'Maksymenko'), (8, 'Timur', '+380684122131', 'kradiymindich@ukr.net', '1986-01-31', 1, 'Mindich'), (9, 'Natalya', '+380689991337', 'logis111@gmail.com', '1990-06-21', 1, 'Shepel'), (10, 'Valentin', '+380686614256', 'tinetakaya@gmail.com', '1999-05-22', 1, 'Strykalo'), (11, 'Viktor', '+380979741501', 'lublukamazi@gmail.com', '1950-07-09', 1, 'Yanik'), (12, 'Iliya', '+380990260612', 'vlobisvistit@gmail.com', '1977-06-02', 1, 'Kiva'), (13, 'Aleksey', '+380990212332', 'tetkoz@gmail.com', '2000-02-27', 1, 'Teterya');

--- Baloban Artem ---
--- Tables: Coach, Personal_training, Coach_class, Coach_specialization ---
CREATE TABLE coach (
    coach_id INT4 GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    hub_id INT4 NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birthday DATE,
    education VARCHAR(150),
    address VARCHAR(150),
    certification VARCHAR(150),
    is_active BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT fk_coach_hub FOREIGN KEY (hub_id) REFERENCES fitness_club(hub_id)
);

CREATE TABLE coach_specialization (
    coach_id INT4 NOT NULL,
    specialization_id INT4 NOT NULL,
    PRIMARY KEY (coach_id, specialization_id),
    CONSTRAINT fk_coach_specialization_coach FOREIGN KEY (coach_id) REFERENCES coach(coach_id) ON DELETE CASCADE,
    CONSTRAINT fk_coach_specialization_spec FOREIGN KEY (specialization_id) REFERENCES specialization(specialization_id) ON DELETE CASCADE
);

CREATE TABLE personal_training (
    training_id INT4 GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INT8 NOT NULL,
    coach_id INT4 NOT NULL,
    starts_at TIMESTAMP NOT NULL,
    ends_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_personal_training_member FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_personal_training_coach FOREIGN KEY (coach_id) REFERENCES coach(coach_id) ON DELETE CASCADE
);

CREATE TABLE coach_class (
  class_id INT NOT NULL,
  coach_id INT NOT NULL,
  FOREIGN KEY (class_id) references classes(class_id),
  FOREIGN KEY (coach_id) references coach(coach_id)
);

INSERT INTO coach (hub_id, first_name, last_name, phone, email, birthday, education, address, certification, is_active)
VALUES 
(1, 'Oleksandr', 'Ivanov', '+380501111111', 'alex1@gmail.com', '1990-05-14', 'NUFVSU', 'Kyiv', 'CrossFit Level 1', true),
(1, 'Dmytro', 'Sidorov', '+380502222222', 'dmitry2@gmail.com', '1988-11-02', 'KNU', 'Lviv', 'Fitness Trainer Pro', true),
(1, 'Maxym', 'Petrov', '+380503333333', 'max3@gmail.com', '1995-07-21', 'KhNU', 'Odesa', 'TRX Instructor', true),
(1, 'Ihor', 'Kovalenko', '+380504444444', 'igor4@gmail.com', '1992-03-17', 'LNU', 'Dnipro', 'Bodybuilding Coach', false),
(1, 'Andriy', 'Melnyk', '+380505555555', 'andrey5@gmail.com', '1987-09-09', 'NUBiP', 'Kharkiv', 'Yoga Trainer', true),
(1, 'Serhiy', 'Bondar', '+380506666666', 'sergey6@gmail.com', '1993-01-30', 'KPI', 'Kyiv', 'Powerlifting Expert', true),
(1, 'Vitaliy', 'Tkachenko', '+380507777777', 'vitaliy7@gmail.com', '1991-06-18', 'ChNU', 'Chernivtsi', 'Cardio Specialist', true),
(1, 'Evheniy', 'Litvin', '+380508888888', 'evgen8@gmail.com', '1996-12-12', 'SumDU', 'Sumy', 'Rehab Trainer', false),
(1, 'Mykola', 'Orlov', '+380509999999', 'nik9@gmail.com', '1989-04-25', 'ONU', 'Odesa', 'Swimming Coach', true),
(1, 'Roman', 'Shevchenko', '+380500000000', 'roman10@gmail.com', '1994-08-08', 'DNU', 'Zaporizhzhia', 'Functional Training', true);

INSERT INTO coach_specialization (coach_id, specialization_id) 
VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5), 
(6, 2), 
(6, 9), 
(7, 6), 
(8, 7), 
(9, 8), 
(10, 9);

INSERT INTO personal_training (member_id, coach_id, starts_at, ends_at) 
VALUES
((SELECT member_id FROM members ORDER BY member_id OFFSET 0 LIMIT 1), 1, '2026-06-01 09:00:00', '2026-06-01 10:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 1 LIMIT 1), 2, '2026-06-01 10:30:00', '2026-06-01 11:30:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 2 LIMIT 1), 1, '2026-06-01 14:00:00', '2026-06-01 15:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 3 LIMIT 1), 3, '2026-06-02 08:00:00', '2026-06-02 09:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 4 LIMIT 1), 2, '2026-06-02 12:00:00', '2026-06-02 13:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 0 LIMIT 1), 4, '2026-06-03 10:00:00', '2026-06-03 11:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 5 LIMIT 1), 3, '2026-06-03 16:00:00', '2026-06-03 17:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 6 LIMIT 1), 1, '2026-06-04 11:00:00', '2026-06-04 12:00:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 7 LIMIT 1), 5, '2026-06-04 18:30:00', '2026-06-04 19:30:00'),
((SELECT member_id FROM members ORDER BY member_id OFFSET 1 LIMIT 1), 4, '2026-06-05 09:00:00', '2026-06-05 10:00:00');

INSERT INTO coach_class (class_id, coach_id) 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10)
