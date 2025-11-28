-- =====================================================
-- STAR SCHEMA CREATION (DIMENSIONS + FACT)
-- CLEANED & OPTIMIZED VERSION
-- =====================================================

-- NOTE:
-- No primary key on fact_orders parent table because
-- PostgreSQL partitioned tables require PK to include
-- partitioning column (invoice_date). Fact tables in
-- warehouses typically DO NOT use PKs for this reason.

--------------------------------------------------------
-- DIM TABLE: dim_customers
--------------------------------------------------------
DROP TABLE IF EXISTS dim_customers CASCADE;

CREATE TABLE dim_customers (
    customer_key     INTEGER PRIMARY KEY,
    customer_id      INTEGER,
    country          VARCHAR(100),
    customer_name    VARCHAR(200)
);

--------------------------------------------------------
-- DIM TABLE: dim_products
--------------------------------------------------------
DROP TABLE IF EXISTS dim_products CASCADE;

CREATE TABLE dim_products (
    product_key      INTEGER PRIMARY KEY,
    product_code     VARCHAR(50),
    description      TEXT
);

--------------------------------------------------------
-- DIM TABLE: dim_date
-- (This will be populated separately in dim_date.sql)
--------------------------------------------------------
DROP TABLE IF EXISTS dim_date CASCADE;

CREATE TABLE dim_date (
    date_key         INTEGER PRIMARY KEY,
    full_date        DATE,
    day              INTEGER,
    month            INTEGER,
    year             INTEGER,
    month_name       VARCHAR(20),
    quarter          INTEGER
);

--------------------------------------------------------
-- FACT TABLE: fact_orders (partitioned)
-- No primary key to avoid partition PK conflicts
--------------------------------------------------------
DROP TABLE IF EXISTS fact_orders_partitioned CASCADE;

CREATE TABLE fact_orders_partitioned (
    fact_order_id    INTEGER,
    invoice_no       VARCHAR(20),
    customer_key     INTEGER,
    product_key      INTEGER,
    invoice_date     TIMESTAMP,
    quantity         INTEGER,
    unit_price       NUMERIC(10, 2),
    total_amount     NUMERIC(12, 2),
    date_key         INTEGER
)
PARTITION BY RANGE (invoice_date);

-- Individual partitions created in:
-- sql/03_fact/fact_orders_partitioning.sql

--------------------------------------------------------
-- Foreign Keys (recommended but not enforced in huge fact tables)
-- Uncomment if needed:
--
-- ALTER TABLE fact_orders_partitioned
-- ADD FOREIGN KEY (customer_key) REFERENCES dim_customers(customer_key);
--
-- ALTER TABLE fact_orders_partitioned
-- ADD FOREIGN KEY (product_key) REFERENCES dim_products(product_key);
--
-- ALTER TABLE fact_orders_partitioned
-- ADD FOREIGN KEY (date_key) REFERENCES dim_date(date_key);
--------------------------------------------------------

