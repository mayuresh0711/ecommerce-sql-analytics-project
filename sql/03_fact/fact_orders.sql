-- fact_orders.sql
-- Compatibility wrapper / convenience view and helper objects.
-- The partitioned table 'fact_orders_partitioned' is created in star_schema.sql.
-- This file provides:
-- 1) a convenience view 'fact_orders' that selects from the partitioned table
-- 2) a staging table definition (staging_fact_orders) to load CSVs before inserting

BEGIN;

-- convenience view (use this in analytics for simplicity)
DROP VIEW IF EXISTS fact_orders CASCADE;
CREATE VIEW fact_orders AS
SELECT *
FROM fact_orders_partitioned;

-- staging table used for safe bulk loads from CSV
DROP TABLE IF EXISTS staging_fact_orders;
CREATE TABLE staging_fact_orders (
    fact_order_id    INTEGER,
    invoice_no       VARCHAR(20),
    customer_key     INTEGER,
    product_key      INTEGER,
    invoice_date     TIMESTAMP,
    quantity         INTEGER,
    unit_price       NUMERIC(10,2),
    total_amount     NUMERIC(12,2),
    date_key         INTEGER
);

COMMIT;
