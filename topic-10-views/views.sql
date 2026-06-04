-- ================================================================
-- SQL VIEWS TEMPLATE (TOPIC 10)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) CREATE VIEW scripts for required view types:
--    - Horizontal view (select specific columns)
--    - Vertical view (filter specific rows)
--    - Mixed view (columns + row filters)
--    - Join-based view (multiple tables)
--    - Subquery-based view
--    - UNION-based view
--    - View based on another view
--    - Updatable view with WITH CHECK OPTION
--
-- 2) Comments before each view explaining:
--    - Purpose of the view
--    - How it supports your project design
--
-- 3) Optional demo SELECT statements to show view output.
--
-- RECOMMENDED ORDER:
-- 1) Simple views (horizontal / vertical / mixed)
-- 2) Join and subquery views
-- 3) UNION and layered views
-- 4) CHECK OPTION view
--
-- IMPORTANT:
-- - Script must execute in PostgreSQL without errors.
-- - Keep naming consistent and readable.
-- - Submit all views in this single SQL file.
-- ================================================================

-- Add your CREATE VIEW statements below this line


--Bozhok Anton
--Не дозволяє зробити дитячу групу занадто великою або змінити дитячу групу на дорослу
CREATE OR REPLACE VIEW children_groups_view AS
SELECT group_id, name, max_members
FROM training_groups
WHERE name LIKE '%children%' AND max_members <= 8
WITH CHECK OPTION;

                                                                --- Baloban Artem ---
--- Tasks: ---
--- 1.Horizontal views — selecting specific columns, for example, a view showing only book titles and authors.
--- 2.Vertical views — selecting specific rows based on conditions, for example, a view showing only overdue borrowings.
--- 5.Views that use subqueries, for example, a view showing books with an average rating above 4.

create or replace view coach_view_city as
Select coach_id, first_name, address
from coach
where address = 'Kyiv';

select * from coach_view_city;

create or replace view personal_view_data as
select c.coach_id, c.first_name as coach_first_name, c.last_name, m.member_id, m.first_name as member_first_name, pt.ends_at
from coach c inner join personal_training pt on c.coach_id = pt.coach_id inner join members m on pt.member_id = m.member_id
Where pt.ends_at::date = DATE '2026-06-01';

select * From personal_view_data;

create or replace view count_members_in_coach as
select c.coach_id, c.first_name, count(pt.member_id) as member_count
from coach c join personal_training pt on c.coach_id = pt.coach_id
where is_active = true
group by c.coach_id, c.first_name
having count(pt.member_id) > (select avg(cnt) from (select count(member_id) as cnt from personal_training group by coach_id) sub);

select * from count_members_in_coach;
