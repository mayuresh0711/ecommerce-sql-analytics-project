DROP MATERIALIZED VIEW IF EXISTS mv_customer_predictions;

CREATE MATERIALIZED VIEW mv_customer_predictions AS
WITH avg_gap AS (
    SELECT
        customer_key,
        AVG(order_date - LAG(order_date) OVER (
            PARTITION BY customer_key ORDER BY order_date
        )) AS avg_days_between
    FROM (
        SELECT DISTINCT customer_key, invoice_no, invoice_date::date AS order_date
        FROM fact_orders
    ) d
),
last_purchase AS (
    SELECT
        customer_key,
        MAX(invoice_date)::date AS last_order_date
    FROM fact_orders
    GROUP BY customer_key
),
next_pred AS (
    SELECT
        l.customer_key,
        last_order_date,
        avg_days_between,
        last_order_date + avg_days_between AS predicted_next_order
    FROM last_purchase l
    JOIN avg_gap a USING(customer_key)
)
SELECT * FROM next_pred;
