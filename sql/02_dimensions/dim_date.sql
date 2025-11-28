-- dim_date.sql
-- Build a classic date dimension (one row per calendar date).
-- Covers 2010-01-01 through 2012-12-31 (adjust range if you want)
-- Usage: run this after creating schema and before loading fact table.

BEGIN;

DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
    date_key    INTEGER PRIMARY KEY,  -- YYYYMMDD format
    full_date   DATE NOT NULL,
    day         INTEGER,
    month       INTEGER,
    year        INTEGER,
    month_name  VARCHAR(20),
    quarter     INTEGER,
    is_weekend  BOOLEAN
);

-- Populate dates
INSERT INTO dim_date (date_key, full_date, day, month, year, month_name, quarter, is_weekend)
SELECT
    (EXTRACT(YEAR FROM d)::int * 10000) + (EXTRACT(MONTH FROM d)::int * 100) + (EXTRACT(DAY FROM d)::int) AS date_key,
    d::date AS full_date,
    EXTRACT(DAY FROM d)::int AS day,
    EXTRACT(MONTH FROM d)::int AS month,
    EXTRACT(YEAR FROM d)::int AS year,
    TO_CHAR(d, 'FMMonth') AS month_name,
    EXTRACT(QUARTER FROM d)::int AS quarter,
    CASE WHEN EXTRACT(ISODOW FROM d) IN (6,7) THEN true ELSE false END AS is_weekend
FROM generate_series('2010-01-01'::date, '2012-12-31'::date, interval '1 day') d
ORDER BY d;

ANALYZE dim_date;

COMMIT;
