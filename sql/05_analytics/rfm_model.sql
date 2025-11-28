DROP VIEW IF EXISTS vw_rfm_segments;

WITH last_purchase AS (
    SELECT customer_key, MAX(invoice_date)::date AS last_order_date
    FROM fact_orders
    GROUP BY customer_key
),
freq AS (
    SELECT customer_key, COUNT(DISTINCT invoice_no) AS total_orders
    FROM fact_orders
    GROUP BY customer_key
),
monetary AS (
    SELECT customer_key, SUM(total_amount) AS total_revenue
    FROM fact_orders
    GROUP BY customer_key
),
combined AS (
    SELECT
        l.customer_key,
        CURRENT_DATE - last_order_date AS recency_days,
        f.total_orders,
        m.total_revenue
    FROM last_purchase l
    JOIN freq f USING(customer_key)
    JOIN monetary m USING(customer_key)
)
SELECT
    customer_key,
    NTILE(4) OVER (ORDER BY recency_days) AS r_score,
    NTILE(4) OVER (ORDER BY total_orders DESC) AS f_score,
    NTILE(4) OVER (ORDER BY total_revenue DESC) AS m_score
FROM combined;
