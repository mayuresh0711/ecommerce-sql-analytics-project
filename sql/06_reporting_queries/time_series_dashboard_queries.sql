-- time_series_dashboard_queries.sql
-- Queries that feed time-series charts, grouped by granularity.

-- 1) Daily revenue series
SELECT
    invoice_date::date AS day,
    SUM(total_amount) AS revenue,
    COUNT(DISTINCT invoice_no) AS orders
FROM fact_orders
GROUP BY day
ORDER BY day;

-- 2) Weekly revenue (ISO week)
SELECT
    DATE_TRUNC('week', invoice_date)::date AS week_start,
    SUM(total_amount) AS revenue,
    COUNT(DISTINCT invoice_no) AS orders
FROM fact_orders
GROUP BY week_start
ORDER BY week_start;

-- 3) Monthly revenue by country (for a stacked chart)
SELECT
    DATE_TRUNC('month', invoice_date)::date AS month_start,
    COALESCE(dc.country, 'Unknown') AS country,
    SUM(total_amount) AS revenue
FROM fact_orders f
LEFT JOIN dim_customers dc ON f.customer_key = dc.customer_key
GROUP BY month_start, country
ORDER BY month_start, revenue DESC;
