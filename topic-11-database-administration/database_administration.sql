-- ================================================================
-- DATABASE ADMINISTRATION TEMPLATE (TOPIC 11)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) CREATE ROLE statements for at least 2 distinct roles.
--    Example roles: read-only analyst, read-write editor.
--
-- 2) GRANT statements assigning appropriate permissions to each role:
--    - Read-only role: GRANT SELECT ON ALL TABLES IN SCHEMA ...
--    - Read-write role: GRANT SELECT, INSERT, UPDATE, DELETE ...
--
-- 3) CREATE USER statements for at least 2 users.
--    Each user must be assigned to one of the defined roles.
--
-- 4) Comments before each section explaining the rationale:
--    - Why this role exists
--    - What access it should and should not have
--
-- RECOMMENDED ORDER:
-- 1) Roles + their GRANTs
-- 2) Users + GRANT ROLE TO USER
-- 3) Optional: REVOKE statements for fine-grained restrictions
-- 4) Optional cleanup block (commented out by default):
--    -- DROP USER ...; DROP ROLE ...;
--
-- IMPORTANT:
-- - Use explicit GRANT / REVOKE statements — do not rely on defaults.
-- - Roles must have meaningfully different permission levels.
-- - Script must execute in PostgreSQL without errors.
-- ================================================================

-- Add your script below this line

--Anton Bozhok
-- Роль яка дозволяє юзеру керувати групами та їх учасниками, наприклад: створювати нові групи, змінювати кількість учасників і так далі.

CREATE ROLE group_manager;

CREATE USER manager WITH PASSWORD 'qwertyui';

GRANT group_manager TO manager;

GRANT USAGE ON SCHEMA public TO group_manager;

GRANT SELECT, UPDATE, INSERT, DELETE ON public.training_groups TO group_manager;

GRANT SELECT, UPDATE, INSERT, DELETE ON public.group_members TO group_manager;

GRANT SELECT, UPDATE, INSERT, DELETE ON public.children_groups_view TO group_manager;

--- Samsonov Maxym
--- Створив роль для працівника рецепції / адміністратора клубу, ця роль може тільки читати/переглядати основну інформацію.

CREATE ROLE club_staff_reader;

GRANT USAGE ON SCHEMA public TO club_staff_reader;

GRANT SELECT ON fitness_club TO club_staff_reader;
GRANT SELECT ON club_work_schedule TO club_staff_reader;
GRANT SELECT ON members TO club_staff_reader;
GRANT SELECT ON coach TO club_staff_reader;
GRANT SELECT ON classes TO club_staff_reader;
GRANT SELECT ON training_groups TO club_staff_reader;
GRANT SELECT ON schedule TO club_staff_reader;
GRANT SELECT ON attendance TO club_staff_reader;
GRANT SELECT ON personal_training TO club_staff_reader;

CREATE USER club_staff_user WITH PASSWORD 'club_staff_123';

GRANT club_staff_reader TO club_staff_user;
