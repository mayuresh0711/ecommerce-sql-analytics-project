DROP MATERIALIZED VIEW IF EXISTS mv_customer_ltv;

CREATE MATERIALIZED VIEW mv_customer_ltv AS
SELECT
    customer_key,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    MIN(invoice_date)::date AS first_purchase,
    MAX(invoice_date)::date AS last_purchase
FROM fact_orders
GROUP BY customer_key;

CREATE INDEX IF NOT EXISTS idx_mv_ltv_cust 
    ON mv_customer_ltv(customer_key);
