DROP VIEW IF EXISTS vw_rolling_revenue;

CREATE VIEW vw_rolling_revenue AS
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS month_start,
        country,
        SUM(total_amount) AS monthly_revenue
    FROM fact_orders f
    JOIN dim_customers d USING(customer_key)
    GROUP BY 1,2
)
SELECT
    month_start,
    country,
    monthly_revenue,
    AVG(monthly_revenue) OVER (
        PARTITION BY country ORDER BY month_start
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_month_avg
FROM monthly;
