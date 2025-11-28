-- fact_orders_insert.sql
-- Load pipeline: copy CSV into staging_fact_orders, then insert into partitioned table.
-- Edit the CSV path if needed. Use psql's \copy when running locally from client.

BEGIN;

-- Example: use psql client to load (uncomment & run in psql)
-- \copy staging_fact_orders(fact_order_id, invoice_no, customer_key, product_key, invoice_date, quantity, unit_price, total_amount, date_key) FROM 'data/cleaned_data/fact_orders.csv' CSV HEADER;

-- If you loaded staging via other means, run the insert:
INSERT INTO fact_orders_partitioned(
    fact_order_id, invoice_no, customer_key, product_key,
    invoice_date, quantity, unit_price, total_amount, date_key
)
SELECT
    fact_order_id, invoice_no, customer_key, product_key,
    invoice_date, quantity, unit_price, total_amount, date_key
FROM staging_fact_orders;

-- Keep staging table (you may truncate it if desired)
-- TRUNCATE staging_fact_orders;

ANALYZE staging_fact_orders;
ANALYZE fact_orders_partitioned;

COMMIT;
