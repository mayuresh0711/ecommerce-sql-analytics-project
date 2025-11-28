-- maintenance_vacuum_analyze.sql
-- Safe maintenance commands to keep planner statistics healthy.
-- Run this periodically after bulk loads or ETL windows.

-- Analyze all tables:
ANALYZE;

-- Vacuum (lightweight)
VACUUM VERBOSE ANALYZE;

-- Vacuum full only when necessary (locks table)
-- VACUUM FULL fact_orders_partitioned;

-- Partition-specific maintenance (recommended)
VACUUM VERBOSE fact_orders_2010;
VACUUM VERBOSE fact_orders_2011;
ANALYZE fact_orders_2010;
ANALYZE fact_orders_2011;
