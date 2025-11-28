-- fact_orders_partitioning.sql
-- Create partition children for each year and an "other" partition.
-- NOTE: partitions must exist BEFORE or AFTER loading data; if you loaded data into parent,
-- PostgreSQL will route to correct partition only if partitions exist. We suggest creating partitions first.

BEGIN;

-- 2010 partition
DROP TABLE IF EXISTS fact_orders_2010;
CREATE TABLE fact_orders_2010
PARTITION OF fact_orders_partitioned
FOR VALUES FROM ('2010-01-01') TO ('2011-01-01');

-- 2011 partition
DROP TABLE IF EXISTS fact_orders_2011;
CREATE TABLE fact_orders_2011
PARTITION OF fact_orders_partitioned
FOR VALUES FROM ('2011-01-01') TO ('2012-01-01');

-- Catch-all earlier dates partition (optional)
DROP TABLE IF EXISTS fact_orders_older;
CREATE TABLE fact_orders_older
PARTITION OF fact_orders_partitioned
FOR VALUES FROM (MINVALUE) TO ('2010-01-01');

-- Future partition (safety)
DROP TABLE IF EXISTS fact_orders_future;
CREATE TABLE fact_orders_future
PARTITION OF fact_orders_partitioned
FOR VALUES FROM ('2012-01-01') TO (MAXVALUE);

COMMIT;
