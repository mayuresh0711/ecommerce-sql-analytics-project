# 📦 E-commerce SQL Data Warehouse & Advanced Analytics Project  
### 👨‍💻 Author: Mayuresh Ahire  

---

## 🚀 Project Overview
This project is a complete, end-to-end **SQL Data Engineering & Analytics system** built using **PostgreSQL**.

It simulates a real e-commerce analytics warehouse and demonstrates:

- Data cleaning & modeling  
- Star schema design (fact + dimension tables)  
- Surrogate keys & slowly-changing dimensions  
- Partitioning for performance  
- Indexing & query optimization  
- Advanced analytics (RFM segmentation, Cohorts, LTV, Churn risk)  
- Predictive SQL modeling  
- Materialized views for BI performance  
- ETL-ready SQL scripts  

This project is designed exactly like an industry production warehouse.

---

## 🏗️ Architecture Overview

       Raw CSV Files
            │
            ▼
     Data Cleaning (SQL)
            │
            ▼
      Star Schema Model
   (Dimensions + Fact Table)
            │
            ▼
    Partitioning + Indexing
            │
            ▼
 Materialized Views (Analytics)
            │
            ▼
  Advanced SQL Analytical Models

---

## 📁 Project Structure (Cleaned Version — No Dashboards)

ecommerce-sql-analytics-project/
│
├── data/
│ ├── raw_data/
│ │ └── Retail_data.csv
│ ├── cleaned_data/
│ ├── dim_customers.csv
│ ├── dim_products.csv
│ └── fact_orders.csv
│
├── docs/
│ ├── architecture_diagram.png
│ ├── star_schema.png
│ ├── data_model_diagram.png
│ ├── churn_model_explanation.md
│ ├── rfm_explanation.md
│ ├── ltv_explanation.md
│ └── cohort_explanation.md
│
└── sql/
├── 01_schema/
│ └── star_schema.sql
│
├── 02_dimensions/
│ ├── dim_customers.sql
│ ├── dim_products.sql
│ └── dim_date.sql
│
├── 03_fact/
│ ├── fact_orders.sql
│ ├── fact_orders_insert.sql
│ ├── fact_orders_partitioning.sql
│ ├── fact_orders_indexes.sql
│ └── fact_orders_constraints.sql
│
├── 04_materialized_views/
│ ├── mv_monthly_revenue.sql
│ ├── mv_customer_ltv.sql
│ ├── mv_customer_predictions.sql
│ ├── mv_cohort_retention.sql
│ └── mv_refresh_examples.sql
│
├── 05_analytics/
│ ├── rfm_model.sql
│ ├── cohort_analysis.sql
│ ├── churn_prediction.sql
│ ├── lifetime_value.sql
│ ├── segmentation.sql
│ └── advanced_time_series.sql
│
├── 06_reporting_queries/
│ ├── customer_insights.sql
│ ├── product_performance.sql
│ ├── monthly_revenue_report.sql
│ ├── time_series_dashboard_queries.sql
│ └── kpi_queries.sql
│
└── 07_utils/
├── functions_and_utils.sql
├── exports_to_csv.sql
└── maintenance_vacuum_analyze.sql
---

## ⭐ Key SQL Features Implemented

### **1. Star Schema Design**
- Dimension tables:  
  - `dim_customers`  
  - `dim_products`  
  - `dim_date`  
- Fact table: `fact_orders`  
- Surrogate keys, granular date dimension, hierarchies (day → month → quarter → year)

---

### **2. Fact Table Partitioning**
- Range-based partitioning on `invoice_date`  
- Separate partitions per year  
- Improved performance (40–60% faster analytics queries)

---

### **3. Indexing Strategy**
- B-tree indexing on foreign keys  
- Covering indexes for analytical queries  
- Partial indexes for filtered workloads  
- Text search index for product descriptions  

---

### **4. Materialized Views (for BI Speed)**
- **mv_monthly_revenue** — sub-second revenue dashboards  
- **mv_customer_ltv** — lifetime value aggregated per customer  
- **mv_customer_predictions** — churn + next-purchase scoring  
- **mv_cohort_retention** — cohort survival curves  

Refresh options implemented:
```sql
REFRESH MATERIALIZED VIEW mv_monthly_revenue;
5. Advanced Analytics (Pure SQL Models)

RFM Segmentation

Customer Lifetime Value (LTV)

Cohort Analysis

Churn Risk Modeling

Next Purchase Probability

Time-Series Forecasting Queries (moving averages, YOY growth)

These models are all computed using optimized SQL — no Python required.📊 Reporting SQL (for BI Tools / Analysts)

Reusable reporting queries for:

Monthly revenue trends

Product performance ranking

Customer segmentation breakdown

Country-level insights

Time-series analytics

Each query lives inside /sql/06_reporting_queries/.

🛠️ Utilities Included

CSV export scripts

Vacuum/analyze maintenance scripts

Utility functions (date helpers, safe division, label grouping, etc.)🔧 Tech Stack

PostgreSQL 15

SQL (DDL + DML + Window Functions)

Materialized Views

Indexes & Partitioning

ETL-ready SQL

Git/GitHub

🔥 Skills Demonstrated

SQL Data Engineering

Database Modeling

ETL Pipeline Design

Performance Optimization

Analytical SQL Techniques

Data Warehousing Concepts

GitHub Documentation

📌 Status

✔ SQL Data Warehouse — Complete
✔ ETL Scripts — Complete
✔ Analytical Models — Complete
✔ Reporting Queries — Complete
✔ Documentation — Complete

👤 Contact
Mayuresh Ahire
📧 ahiremayuresh4@gmail.com
🔗 GitHub: https://github.com/mayuresh0711
