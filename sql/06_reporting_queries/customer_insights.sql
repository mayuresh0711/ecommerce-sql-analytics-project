-- customer_insights.sql
-- Customer-level reporting for dashboards and export.

-- 1) Top customers by lifetime revenue (top 25)
SELECT
    c.customer_key,
    COALESCE(dc.customer_id, c.customer_key) AS customer_id,
    COALESCE(dc.country, 'Unknown') AS country,
    SUM(f.total_amount) AS lifetime_revenue,
    COUNT(DISTINCT f.invoice_no) AS orders,
    AVG(f.total_amount) AS avg_order_value,
    MIN(f.invoice_date)::date AS first_purchase,
    MAX(f.invoice_date)::date AS last_purchase
FROM fact_orders f
LEFT JOIN dim_customers dc ON f.customer_key = dc.customer_key
JOIN (SELECT customer_key FROM fact_orders GROUP BY customer_key) c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, dc.customer_id, dc.country
ORDER BY lifetime_revenue DESC
LIMIT 25;

-- 2) New vs returning customers per month
WITH first_order AS (
    SELECT customer_key, MIN(invoice_date)::date AS first_order_date
    FROM fact_orders
    GROUP BY customer_key
),
monthly AS (
    SELECT
        DATE_TRUNC('month', invoice_date)::date AS month_start,
        customer_key
    FROM fact_orders
)
SELECT
    m.month_start,
    COUNT(DISTINCT CASE WHEN fo.first_order_date >= m.month_start AND fo.first_order_date < (m.month_start + INTERVAL '1 month') THEN m.customer_key END) AS new_customers,
    COUNT(DISTINCT CASE WHEN fo.first_order_date < m.month_start THEN m.customer_key END) AS returning_customers
FROM monthly m
LEFT JOIN first_order fo USING (customer_key)
GROUP BY m.month_start
ORDER BY m.month_start;
