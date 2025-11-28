-- mv_monthly_revenue.sql
-- Monthly Revenue MV (fast for dashboards)

DROP MATERIALIZED VIEW IF EXISTS mv_monthly_revenue;

CREATE MATERIALIZED VIEW mv_monthly_revenue AS
SELECT
    DATE_TRUNC('month', invoice_date) AS month_start,
    SUM(total_amount) AS monthly_revenue,
    COUNT(DISTINCT invoice_no) AS num_orders,
    COUNT(*) AS num_line_items
FROM fact_orders
GROUP BY 1
ORDER BY 1;

-- Index to support dashboard filtering
CREATE INDEX IF NOT EXISTS idx_mv_month_rev_month 
    ON mv_monthly_revenue(month_start);
