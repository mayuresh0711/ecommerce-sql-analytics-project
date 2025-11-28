-- product_performance.sql
-- Product-level KPIs for product analytics dashboards.

-- 1) Top products by revenue (top 50)
SELECT
    p.product_key,
    COALESCE(dp.product_code, p.product_key::text) AS product_code,
    COALESCE(dp.description, '') AS description,
    SUM(f.total_amount) AS revenue,
    SUM(f.quantity) AS total_units_sold,
    COUNT(DISTINCT f.invoice_no) AS num_orders,
    ROUND(SUM(f.total_amount)::numeric / NULLIF(COUNT(DISTINCT f.invoice_no),0),2) AS avg_order_value
FROM fact_orders f
LEFT JOIN dim_products dp ON f.product_key = dp.product_key
JOIN (SELECT product_key FROM fact_orders GROUP BY product_key) p ON f.product_key = p.product_key
GROUP BY p.product_key, dp.product_code, dp.description
ORDER BY revenue DESC
LIMIT 50;

-- 2) Product sales by month (example product_key parameter)
-- Replace :product_key with an integer or use WHERE product_key = 123
SELECT
    DATE_TRUNC('month', invoice_date)::date AS month_start,
    SUM(total_amount) AS monthly_revenue,
    SUM(quantity) AS monthly_units
FROM fact_orders
WHERE product_key = :product_key
GROUP BY 1
ORDER BY 1;
