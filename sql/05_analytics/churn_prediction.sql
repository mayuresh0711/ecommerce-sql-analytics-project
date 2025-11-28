DROP VIEW IF EXISTS vw_customer_churn;

WITH analysis AS (
    SELECT (MAX(invoice_date)::date + 1) AS analysis_date FROM fact_orders
),
last_purchase AS (
    SELECT customer_key, MAX(invoice_date)::date AS last_order_date
    FROM fact_orders
    GROUP BY customer_key
),
combined AS (
    SELECT
        l.customer_key,
        last_order_date,
        a.analysis_date,
        (a.analysis_date - last_order_date) AS inactivity_days
    FROM last_purchase l, analysis a
)
SELECT
    *,
    CASE WHEN inactivity_days > 90 THEN 'Churned'
         ELSE 'Active'
    END AS status
FROM combined;
