-- kpi_queries.sql
-- Short queries that power KPI cards on dashboards.

-- 1) Today's / last available day revenue
SELECT
    (SELECT MAX(invoice_date)::date FROM fact_orders) AS last_data_date,
    (SELECT SUM(total_amount) FROM fact_orders WHERE invoice_date::date = (SELECT MAX(invoice_date)::date FROM fact_orders)) AS revenue_on_last_date;

-- 2) MTD revenue & YoY comparison (Month To Date)
WITH bounds AS (
    SELECT
        date_trunc('month', MAX(invoice_date))::date AS month_start,
        (date_trunc('month', MAX(invoice_date)) - INTERVAL '1 year')::date AS month_start_prev
    FROM fact_orders
)
SELECT
    -- This month
    (SELECT SUM(total_amount) FROM fact_orders f JOIN bounds b ON true WHERE f.invoice_date >= b.month_start) AS mtd_revenue,
    -- Same month last year
    (SELECT SUM(total_amount) FROM fact_orders f JOIN bounds b ON true WHERE f.invoice_date >= b.month_start_prev AND f.invoice_date < b.month_start_prev + INTERVAL '1 month') AS mtd_revenue_last_year;

-- 3) Active customers (last 30 days)
SELECT COUNT(DISTINCT customer_key) AS active_customers_30d
FROM fact_orders
WHERE invoice_date >= (SELECT MAX(invoice_date) - INTERVAL '30 days' FROM fact_orders);
