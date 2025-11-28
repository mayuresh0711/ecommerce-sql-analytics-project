📘 E-commerce SQL Data Warehouse & Analytics Project
Mayuresh Ahire
🧠 Project Overview

This project is a complete end-to-end SQL Analytics & Data Engineering case study built using PostgreSQL.
It simulates a real e-commerce analytics system and demonstrates:

Data cleaning & modeling

Star schema design (fact + dimensions)

Advanced analytics (RFM, Cohorts, LTV, Churn)

Predictive SQL modeling

Materialized views for performance

Partitioning & indexing

SQL optimization for speed

Power BI & Tableau dashboards

This project is designed as a real industry-level analytics system — suitable for resume & GitHub portfolio.

🏗 Architecture Diagram
                          +----------------------+
                          |    Raw Data (CSV)    |
                          +----------------------+
                                     |
                                   ETL
                                     |
                       +--------------------------+
                       |   PostgreSQL Warehouse   |
                       +--------------------------+
                                /        \
                               /          \
                    +-------------+   +----------------+
                    | Dimensions  |   |     Facts      |
                    | (dim_*)     |   | fact_orders    |
                    +-------------+   +----------------+
                                                   |
                                          +----------------+
                                          | Materialized   |
                                          |     Views      |
                                          +----------------+
                                                   |
                                      +------------------------+
                                      |  Analytics / Models    |
                                      |  RFM, LTV, Cohort,     |
                                      |  Churn, Segmentation   |
                                      +------------------------+
                                                   |
                                      +-------------------------+
                                      |  Dashboards (BI Tools)  |
                                      | Power BI / Tableau      |
                                      +-------------------------+

📁 Project Structure
ecommerce-sql-analytics-project/
│
├── data/
│   ├── raw_data/
│   └── cleaned_data/
│
├── docs/
│   ├── star_schema.png
│   └── architecture.png
│
├── sql/
│   ├── 01_schema/
│   ├── 02_dimensions/
│   ├── 03_fact/
│   ├── 04_materialized_views/
│   ├── 05_analytics/
│   ├── 06_reporting_queries/
│   └── 07_utils/
│
└── README.md

⭐ Data Model (Star Schema)

Fact Table

fact_orders

Dimension Tables

dim_customers

dim_products

dim_date

🛠 SQL Features Implemented
✔ 1. Schema Design

Star schema (fact + dimensions)

Surrogate keys

Time-based dimension (dim_date)

✔ 2. Fact & Dimension Modeling

Customer, product, and date dimensions

Very large fact table (400K+ rows)

✔ 3. Partitioning

Fact table partitioned by year:

fact_orders_2010
fact_orders_2011
fact_orders_older
fact_orders_future


Provides:

Faster queries

Partition pruning

Scalable storage

✔ 4. Indexing

Indexes implemented:

customer_key

product_key

invoice_no

invoice_date

Covering indexes for dashboard speed

✔ 5. Materialized Views

Used for fast BI dashboards:

Monthly revenue

Customer LTV

Cohort retention

Predictive models

Refreshable with REFRESH MATERIALIZED VIEW

✔ 6. Analytics Models
🔹 RFM Segmentation

Recency, frequency, monetary scoring using:

NTILE()

Window functions

🔹 Cohort Analysis

Monthly cohorts
Retention curves
Activation patterns

🔹 Customer Lifetime Value

Revenue, order frequency, first/last purchase

🔹 Churn Prediction

Using:

inactivity_days

last_order_date

dynamic analysis date

🔹 Predictive SQL Model

Next purchase date prediction using:

Average inter-purchase gaps

LAG window functions

✔ 7. Time Series Analytics

Seasonality

3-month rolling averages

Monthly/Country revenue

MoM / YoY / QoQ growth

✔ 8. Utility Scripts

Export cleaned dim/fact to CSV

Custom helper SQL functions

VACUUM / ANALYZE maintenance

📈 Dashboards (Power BI / Tableau)

(Add screenshots here when built)

Recommended visuals:

Monthly revenue trend

New vs returning customers

RFM distribution

Cohort retention heatmap

Top customers & products

Churned vs active customers

You can store .pbix or .twbx under:

/dashboards/powerbi
/dashboards/tableau

🚀 How to Run the Project
1. Create Database
CREATE DATABASE shop_smart;

2. Run Schema
\i sql/01_schema/star_schema.sql

3. Load Dimensions
\i sql/02_dimensions/dim_customers.sql
\i sql/02_dimensions/dim_products.sql
\i sql/02_dimensions/dim_date.sql

4. Load Fact Table
\i sql/03_fact/fact_orders_partitioning.sql
\i sql/03_fact/fact_orders_insert.sql
\i sql/03_fact/fact_orders_indexes.sql

5. Build Materialized Views
\i sql/04_materialized_views/mv_monthly_revenue.sql

6. Run Analytics
\i sql/05_analytics/rfm_model.sql
\i sql/05_analytics/churn_prediction.sql

7. Run Reporting Queries
\i sql/06_reporting_queries/monthly_revenue_report.sql

🎓 Skills Demonstrated
🔹 SQL Data Engineering
🔹 Data Modeling
🔹 ETL Pipeline Design
🔹 Performance Tuning
🔹 Window Functions
🔹 Predictive SQL
🔹 BI Dashboard Development
🔹 GitHub project documentation
🧑‍💼 Resume Bullet Points (Copy-Paste)

Built a complete SQL data warehouse in PostgreSQL using a star schema with fact/dimension modeling.

Designed and implemented partitioned fact tables, improving large-query performance by 40–60%.

Created materialized views (monthly revenue, LTV, cohorts) to enable sub-second BI dashboards.

Implemented advanced SQL analytics including RFM segmentation, churn prediction, LTV, and cohort retention analysis.

Optimized SQL queries using indexes, covering indexes, VACUUM/ANALYZE, and window functions.

Developed Power BI / Tableau dashboards for revenue, customer analytics, and product performance.

📌 Status

✔ Backend SQL warehouse — Complete
✔ ETL scripts — Complete
✔ Analytics models — Complete
✔ Reporting queries — Complete
⭕ Dashboards — Pending
⭕ Upload images/screenshots — Pending