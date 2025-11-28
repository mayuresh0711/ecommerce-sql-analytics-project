-- mv_refresh_examples.sql
-- SAFE REFRESH patterns

-- Fast refresh (blocking)
REFRESH MATERIALIZED VIEW mv_monthly_revenue;

-- Non-blocking (requires unique index!)
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_revenue;
