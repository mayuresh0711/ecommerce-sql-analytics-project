-- monthly_revenue_report.sql
-- Reporting queries to support dashboard tiles and exportable reports.
-- Assumes mv_monthly_revenue exists (materialized view built earlier).
-- If you prefer to compute on the fly, replace mv_monthly_revenue with the underlying query.

-- 1) Basic monthly revenue time series
SELECT
    month_start,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month_start) AS prev_month_revenue,
    CASE
        WHEN LAG(monthly_revenue) OVER (ORDER BY month_start) IS NULL THEN NULL
        ELSE ROUND((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month_start)) * 100.0 / NULLIF(LAG(monthly_revenue) OVER (ORDER BY month_start),0),2)
    END AS mom_pct_change
FROM mv_monthly_revenue
ORDER BY month_start;

-- 2) Top 10 months by revenue
SELECT month_start, monthly_revenue
FROM mv_monthly_revenue
ORDER BY monthly_revenue DESC
LIMIT 10;

-- 3) Monthly orders & avg order value
SELECT
    m.month_start,
    m.monthly_revenue,
    m.num_orders,
    CASE WHEN m.num_orders = 0 THEN 0 ELSE ROUND(m.monthly_revenue::numeric / m.num_orders, 2) END AS avg_order_value
FROM mv_monthly_revenue m
ORDER BY m.month_start;
