-- exports_to_csv.sql
-- Example scripts to export cleaned dim/fact tables to CSV files under data/cleaned_data.
-- NOTE: Use COPY when running on the server; use \copy in psql client if file path is client-local.

-- Export dim_customers
COPY (
    SELECT customer_key, customer_id, country, customer_name
    FROM dim_customers
    ORDER BY customer_key
) TO 'data/cleaned_data/dim_customers.csv' WITH CSV HEADER;

-- Export dim_products
COPY (
    SELECT product_key, product_code, description
    FROM dim_products
    ORDER BY product_key
) TO 'data/cleaned_data/dim_products.csv' WITH CSV HEADER;

-- Export dim_date
COPY (
    SELECT date_key, full_date, day, month, year, month_name, quarter, is_weekend
    FROM dim_date
    ORDER BY full_date
) TO 'data/cleaned_data/dim_date.csv' WITH CSV HEADER;

-- Export fact_orders (note: can be large; use with care)
COPY (
    SELECT *
    FROM fact_orders
    ORDER BY invoice_date
) TO 'data/cleaned_data/fact_orders.csv' WITH CSV HEADER;
