DROP VIEW IF EXISTS vw_customer_lifetime_value;

CREATE VIEW vw_customer_lifetime_value AS
SELECT
    customer_key,
    SUM(total_amount) AS ltv,
    AVG(total_amount) AS avg_order_value,
    COUNT(DISTINCT invoice_no) AS total_orders,
    MIN(invoice_date)::date AS first_purchase,
    MAX(invoice_date)::date AS last_purchase
FROM fact_orders
GROUP BY customer_key;
