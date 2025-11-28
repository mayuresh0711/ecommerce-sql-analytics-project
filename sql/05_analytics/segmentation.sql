DROP VIEW IF EXISTS vw_customer_segments;

CREATE VIEW vw_customer_segments AS
SELECT
    r.customer_key,
    r.r_score,
    r.f_score,
    r.m_score,
    c.country
FROM rfm_model r
LEFT JOIN dim_customers c USING(customer_key);
