-- dim_customers.sql
-- Build the customer dimension from the cleaned fact or raw staging.
-- NOTE: This script assumes you will either (A) load cleaned CSV into staging table staging_fact_orders
-- or (B) extract distinct customers from the partitioned fact_orders_partitioned table.
-- We include both options; uncomment the one you will use.

BEGIN;

DROP TABLE IF EXISTS dim_customers;
CREATE TABLE dim_customers (
    customer_key    INTEGER PRIMARY KEY,
    customer_id     INTEGER,         -- original customer id from raw dataset
    country         VARCHAR(100),
    customer_name   VARCHAR(200)
);

-- OPTION A: populate from a cleaned CSV staged table (preferred if you pre-cleaned)
-- Assumes you have loaded cleaned customers into staging_customers(customer_id, country, name)
-- INSERT INTO dim_customers(customer_key, customer_id, country, customer_name)
-- SELECT ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key, customer_id, country, name
-- FROM staging_customers;

-- OPTION B: derive customers directly from fact_orders_partitioned (if cleaned CSV not available)
INSERT INTO dim_customers(customer_key, customer_id, country, customer_name)
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_key) AS customer_key,
    customer_key AS customer_id,
    country,
    NULL::varchar AS customer_name
FROM (
    SELECT DISTINCT customer_key, NULL::varchar AS country
    FROM fact_orders_partitioned
    WHERE customer_key IS NOT NULL
) x
ORDER BY customer_key;

-- NOTE: If you have a separate customers source (cleaned CSV) prefer Option A.
ANALYZE dim_customers;

COMMIT;
