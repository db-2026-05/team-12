-- ================================================================
-- SQL DDL TEMPLATE (TOPIC 04)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) Full PostgreSQL DDL for your finalized schema.
-- 2) CREATE TABLE statements for all entities from your ER diagram.
-- 3) Primary keys, foreign keys, NOT NULL, UNIQUE, CHECK constraints.
-- 4) Indexes for important search/join columns.
-- 5) Clean structure and comments (group by tables/constraints/indexes).
--
-- RECOMMENDED ORDER:
-- 1) Tables
-- 2) Constraints (if not inline)
-- 3) Indexes
--
-- TEAM NOTE:
-- Add short attribution comments for who implemented which part.
-- Example:
-- [Name] - users, roles, permissions tables
-- [Name] - orders, payments, invoices tables
--
-- IMPORTANT:
-- The script must run in PostgreSQL and produce a working schema that
-- matches your approved ER diagram and conceptual schema.
-- Submit this as one SQL file.
-- ================================================================

-- Add your DDL below this line

CREATE TABLE public.attendance (
  member_id bigint NOT NULL,
  status character varying NOT NULL,
  schedule_id bigint NOT NULL,
  CONSTRAINT attendance_pkey PRIMARY KEY (member_id, schedule_id),
  CONSTRAINT attendance_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id),
  CONSTRAINT attendance_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedule(schedule_id)
);
CREATE TABLE public.classes (
  class_id integer NOT NULL DEFAULT nextval('classes_class_id_seq'::regclass),
  class_name character varying,
  CONSTRAINT classes_pkey PRIMARY KEY (class_id)
);
CREATE TABLE public.coach (
  coach_id integer NOT NULL DEFAULT nextval('coach_coach_id_seq'::regclass),
  full_name character varying NOT NULL,
  phone character varying NOT NULL,
  email character varying NOT NULL UNIQUE,
  birthday date,
  education character varying,
  address character varying,
  certification character varying,
  CONSTRAINT coach_pkey PRIMARY KEY (coach_id)
);
CREATE TABLE public.coach_class (
  class_id integer NOT NULL,
  coach_id integer NOT NULL,
  CONSTRAINT coach_class_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id),
  CONSTRAINT coach_class_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coach(coach_id)
);
CREATE TABLE public.coach_specialization (
  coach_id integer NOT NULL,
  specialization_id integer NOT NULL,
  CONSTRAINT coach_specialization_specialization_id_fkey FOREIGN KEY (specialization_id) REFERENCES public.specialization(specialization_id),
  CONSTRAINT coach_specialization_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coach(coach_id)
);
CREATE TABLE public.equipment (
  equipment_id bigint NOT NULL DEFAULT nextval('equipment_equipment_id_seq'::regclass),
  hub_id bigint NOT NULL,
  date_receipt date,
  last_service date,
  inventory_number character varying,
  name character varying,
  status character varying,
  wear_percentage numeric,
  CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id),
  CONSTRAINT fk_equipment_fitness_club FOREIGN KEY (hub_id) REFERENCES public.fitness_club(hub_id)
);
CREATE TABLE public.fitness_club (
  hub_id bigint NOT NULL DEFAULT nextval('fitness_club_hub_id_seq'::regclass),
  address character varying,
  phone character varying,
  work_hours character varying,
  CONSTRAINT fitness_club_pkey PRIMARY KEY (hub_id)
);
CREATE TABLE public.members (
  member_id bigint NOT NULL DEFAULT nextval('members_member_id_seq'::regclass),
  full_name character varying NOT NULL,
  phone character varying NOT NULL,
  email character varying UNIQUE,
  birthday date NOT NULL,
  hub_id integer,
  CONSTRAINT members_pkey PRIMARY KEY (member_id),
  CONSTRAINT members_hub_id_fkey FOREIGN KEY (hub_id) REFERENCES public.fitness_club(hub_id)
);
CREATE TABLE public.personal_training (
  training_id integer NOT NULL DEFAULT nextval('personal_training_training_id_seq'::regclass),
  member_id bigint NOT NULL,
  coach_id integer NOT NULL,
  date date NOT NULL,
  CONSTRAINT personal_training_pkey PRIMARY KEY (training_id),
  CONSTRAINT fr_coach FOREIGN KEY (coach_id) REFERENCES public.coach(coach_id),
  CONSTRAINT personal_training_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id)
);
CREATE TABLE public.prices (
  price_id bigint NOT NULL DEFAULT nextval('prices_price_id_seq'::regclass),
  type_id bigint NOT NULL,
  duration_id bigint NOT NULL,
  price numeric NOT NULL CHECK (price > 0::numeric),
  CONSTRAINT prices_pkey PRIMARY KEY (price_id),
  CONSTRAINT prices_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.subscription_type(type_id),
  CONSTRAINT prices_duration_id_fkey FOREIGN KEY (duration_id) REFERENCES public.subscription_duration(duration_id)
);
CREATE TABLE public.progress (
  progress_id bigint NOT NULL DEFAULT nextval('progress_progress_id_seq'::regclass),
  member_id bigint NOT NULL,
  progress_type character varying NOT NULL,
  current_progress numeric,
  target numeric,
  status character varying NOT NULL,
  started_at date NOT NULL,
  last_update timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT progress_pkey PRIMARY KEY (progress_id),
  CONSTRAINT progress_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id)
);
CREATE TABLE public.schedule (
  schedule_id bigint NOT NULL,
  class_id integer NOT NULL,
  group_id integer NOT NULL,
  date date,
  time time without time zone,
  duration bigint,
  CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id),
  CONSTRAINT schedule_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id),
  CONSTRAINT schedule_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.training_groups(group_id)
);
CREATE TABLE public.specialization (
  specialization_id integer NOT NULL DEFAULT nextval('specialization_specialization_id_seq'::regclass),
  name character varying,
  CONSTRAINT specialization_pkey PRIMARY KEY (specialization_id)
);
CREATE TABLE public.subscription (
  subscription_id bigint NOT NULL DEFAULT nextval('subscription_subscription_id_seq'::regclass),
  member_id bigint NOT NULL,
  price_id bigint NOT NULL,
  start_date date,
  end_date date,
  status character varying NOT NULL,
  CONSTRAINT subscription_pkey PRIMARY KEY (subscription_id),
  CONSTRAINT subscription_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id),
  CONSTRAINT subscription_price_id_fkey FOREIGN KEY (price_id) REFERENCES public.prices(price_id)
);
CREATE TABLE public.subscription_duration (
  duration_id bigint NOT NULL DEFAULT nextval('subscription_duration_duration_id_seq'::regclass),
  duration_name character varying NOT NULL,
  CONSTRAINT subscription_duration_pkey PRIMARY KEY (duration_id)
);
CREATE TABLE public.subscription_type (
  type_id bigint NOT NULL DEFAULT nextval('subscription_type_type_id_seq'::regclass),
  type_name character varying NOT NULL,
  CONSTRAINT subscription_type_pkey PRIMARY KEY (type_id)
);
CREATE TABLE public.training_groups (
  group_id integer NOT NULL DEFAULT nextval('training_groups_group_id_seq'::regclass),
  name character varying,
  max_members integer,
  CONSTRAINT training_groups_pkey PRIMARY KEY (group_id)
);



