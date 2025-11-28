-- functions_and_utils.sql
-- Small helper functions and reusable utilities that support the analytics.

-- 1) Helper: Get analysis date (max invoice_date + 1 day)
CREATE OR REPLACE FUNCTION fn_get_analysis_date()
RETURNS DATE LANGUAGE SQL STABLE AS $$
    SELECT (MAX(invoice_date)::date + 1) FROM fact_orders;
$$;

-- Usage: SELECT fn_get_analysis_date();

-- 2) Helper: Days between two dates (simple)
CREATE OR REPLACE FUNCTION fn_days_between(d1 DATE, d2 DATE)
RETURNS INTEGER LANGUAGE SQL IMMUTABLE AS $$
    SELECT (d1 - d2)::int;
$$;

-- 3) Utility: Safe percentile (wraps PERCENTILE_CONT)
-- Example: SELECT fn_median_days_between() FROM ... uses underlying gaps table; we provide example placeholder.
-- (You can adapt this to your needs.)
CREATE OR REPLACE FUNCTION fn_median_from_numeric_table(val numeric[])
RETURNS numeric LANGUAGE SQL IMMUTABLE AS $$
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY UNNEST(val));
$$;
