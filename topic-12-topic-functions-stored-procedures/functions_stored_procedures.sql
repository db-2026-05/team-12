-- ================================================================
-- FUNCTIONS & STORED PROCEDURES TEMPLATE (TOPIC 12)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
--
-- FUNCTIONS (at least 3):
--   - Each function should encapsulate reusable logic or a
--     calculation relevant to your project domain.
--   - Use CREATE OR REPLACE FUNCTION ... RETURNS ...
--
-- STORED PROCEDURES — SELECT / INSERT (at least 2):
--   - Procedures that retrieve data or insert new records.
--   - Use CREATE OR REPLACE PROCEDURE ...
--
-- STORED PROCEDURES — UPDATE (at least 2):
--   - Procedures that modify existing records.
--
-- FOR EACH FUNCTION / PROCEDURE, ADD COMMENTS EXPLAINING:
--   - Purpose: what it does
--   - Parameters: name, type, meaning
--   - Expected behavior / return value
--
-- TEST CALLS:
--   - Include at least one example call per function/procedure
--     (SELECT my_function(...) or CALL my_procedure(...))
--
-- OPTIONAL:
--   - EXCEPTION blocks for error handling
--   - Transaction management with BEGIN / COMMIT / ROLLBACK
--
-- RECOMMENDED ORDER:
-- 1) Functions
-- 2) SELECT / INSERT procedures
-- 3) UPDATE procedures
-- 4) Test calls
--
-- IMPORTANT:
-- - All routines must execute in PostgreSQL without errors.
-- - Logic must be relevant to your project domain.
-- - Submit everything in this single SQL file.
-- ================================================================

-- Add your functions and procedures below this line

--Anton Bozhok
--Функція обрахунку поточної кількості учасників групи
CREATE OR REPLACE FUNCTION public.count_group_members (_group_id BIGINT)
RETURNS INT AS $$
DECLARE 
  members_quantity INT;
BEGIN 
  SELECT COUNT(member_id) INTO members_quantity
  FROM group_members
  WHERE group_id = _group_id;
  RETURN members_quantity;
END;
$$ LANGUAGE plpgsql;

--Перевірка
SELECT public.count_group_members(1);

SELECT public.count_group_members(6);

--Процедура для внесення даних про нову групу
CREATE OR REPLACE PROCEDURE public.create_group(
  id BIGINT,
  group_name varchar(30),
  max_group_members INT = 8
)
LANGUAGE plpgsql
AS
$$
BEGIN 
  INSERT INTO training_groups VALUES(id, group_name, max_group_members);
END;
$$;

--Перевірка
CALL create_group (12, 'Swimming Children Group', 4);

SELECT * 
FROM training_groups
WHERE group_id = 12;

