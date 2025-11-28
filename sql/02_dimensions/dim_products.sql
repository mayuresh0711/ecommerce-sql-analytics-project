-- dim_products.sql
-- Build the product dimension. Similar options as dim_customers.

BEGIN;

DROP TABLE IF EXISTS dim_products;
CREATE TABLE dim_products (
    product_key     INTEGER PRIMARY KEY,
    product_code    VARCHAR(50),
    description     TEXT
);

-- OPTION A: load from cleaned products staging (if available)
-- INSERT INTO dim_products(product_key, product_code, description)
-- SELECT ROW_NUMBER() OVER (ORDER BY product_code) AS product_key, product_code, description
-- FROM staging_products;

-- OPTION B: derive from fact_orders_partitioned
INSERT INTO dim_products(product_key, product_code, description)
SELECT
    ROW_NUMBER() OVER (ORDER BY product_key) AS product_key,
    product_key::text AS product_code,
    NULL::text AS description
FROM (
    SELECT DISTINCT product_key
    FROM fact_orders_partitioned
    WHERE product_key IS NOT NULL
) t
ORDER BY product_key;

ANALYZE dim_products;

COMMIT;
