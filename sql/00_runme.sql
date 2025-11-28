-- ============================================================
-- 00_runme.sql
-- MASTER EXECUTION SCRIPT FOR THE FULL DATA WAREHOUSE
-- ============================================================

\echo '=== STEP 1: Creating schema ==='
\i sql/01_schema/create_schema.sql

\echo '=== STEP 2: Creating Star Schema (Dimensions + Fact) ==='
\i sql/01_schema/star_schema.sql

\echo '=== STEP 3: Creating Dimensions (DDL + Populate) ==='
\i sql/02_dimensions/dim_date.sql
\i sql/02_dimensions/dim_customers.sql
\i sql/02_dimensions/dim_products.sql

\echo '=== STEP 4: Creating Fact Table (DDL) ==='
\i sql/03_fact/fact_orders.sql

\echo '=== STEP 5: Loading fact_orders data ==='
\i sql/03_fact/fact_orders_insert.sql

\echo '=== STEP 6: Partitioning fact_orders table ==='
\i sql/03_fact/fact_orders_partitioning.sql

\echo '=== STEP 7: Creating Indexes ==='
\i sql/03_fact/fact_orders_indexes.sql

\echo '=== STEP 8: Creating Materialized Views ==='
\i sql/04_materialized_views/mv_monthly_revenue.sql
\i sql/04_materialized_views/mv_customer_ltv.sql
\i sql/04_materialized_views/mv_cohort_retention.sql
\i sql/04_materialized_views/mv_customer_predictions.sql

\echo '=== STEP 9: Running Advanced Analytics Models ==='
\i sql/05_analytics/rfm_model.sql
\i sql/05_analytics/cohort_analysis.sql
\i sql/05_analytics/lifetime_value.sql
\i sql/05_analytics/churn_prediction.sql
\i sql/05_analytics/segmentation.sql
\i sql/05_analytics/advanced_time_series.sql

\echo '=== STEP 10: Reporting queries (for BI) ==='
\i sql/06_reporting_queries/monthly_revenue_report.sql
\i sql/06_reporting_queries/customer_insights.sql
\i sql/06_reporting_queries/product_performance.sql
\i sql/06_reporting_queries/kpi_queries.sql
\i sql/06_reporting_queries/time_series_dashboard_queries.sql

\echo '=== STEP 11: Export cleaned dims/facts to CSV ==='
\i sql/07_utils/exports_to_csv.sql

\echo '=== STEP 12: Analyze tables for optimal planner statistics ==='
ANALYZE;

\echo '=== DONE ==='
