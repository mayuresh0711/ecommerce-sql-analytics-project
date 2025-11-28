DROP VIEW IF EXISTS vw_cohort_analysis;

WITH cohorts AS (
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
FROM cohorts c
JOIN activity a USING(customer_key)
GROUP BY 1,2
ORDER BY 1,2;
