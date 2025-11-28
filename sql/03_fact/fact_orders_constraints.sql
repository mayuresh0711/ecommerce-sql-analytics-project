-- fact_orders_constraints.sql
-- ============================================================
-- Optional foreign key constraints for fact_orders_partitioned
-- (Commented out because large fact tables in data warehouses
--  typically do NOT enforce FK constraints due to performance.)
--
-- WHY NOT ENFORCE FK CONSTRAINTS ON FACT TABLES?
-- ------------------------------------------------------------
-- ✔ Fact tables contain millions of rows.
-- ✔ FK checks cause large insert slowdowns.
-- ✔ Dimension tables rarely change.
-- ✔ BI/analytics workloads prefer speed over strict constraints.
-- ✔ Surrogate keys are guaranteed clean during ETL.
--
-- In interviews, you should explain that FK constraints are
-- usually documented, but not enforced physically.
--
-- If someone wants to enforce FK constraints anyway, here
-- are the correct definitions. They are commented out so
-- they do not slow down your ETL or cause errors.
-- ============================================================

-- ALTER TABLE fact_orders_partitioned
--   ADD CONSTRAINT fk_fact_customer
--   FOREIGN KEY (customer_key) REFERENCES dim_customers(customer_key);

-- ALTER TABLE fact_orders_partitioned
--   ADD CONSTRAINT fk_fact_product
--   FOREIGN KEY (product_key) REFERENCES dim_products(product_key);

-- ALTER TABLE fact_orders_partitioned
--   ADD CONSTRAINT fk_fact_date
--   FOREIGN KEY (date_key) REFERENCES dim_date(date_key);

-- End of documentation file.
