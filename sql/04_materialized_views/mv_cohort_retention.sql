DROP MATERIALIZED VIEW IF EXISTS mv_cohort_retention;

CREATE MATERIALIZED VIEW mv_cohort_retention AS
WITH customers AS (
    SELECT
        customer_key,
        MIN(DATE_TRUNC('month', invoice_date)) AS cohort_month
    FROM fact_orders
    GROUP BY customer_key
),
activity AS (
    SELECT
        customer_key,
        DATE_TRUNC('month', invoice_date) AS activity_month
    FROM fact_orders
)
SELECT
    c.cohort_month,
    a.activity_month,
    COUNT(DISTINCT a.customer_key) AS active_customers
FROM customers c
JOIN activity a ON c.customer_key = a.customer_key
GROUP BY 1, 2
ORDER BY 1, 2;
