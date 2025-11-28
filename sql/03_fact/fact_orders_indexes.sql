-- fact_orders_indexes.sql
-- Create indexes on partitions. Because PostgreSQL does not automatically create indexes on partitions,
-- we create the indexes for every child partition. This script uses dynamic SQL to create the same
-- named index on every partition if it does not exist.

-- IMPORTANT: run this after partitions exist.

DO
$$
DECLARE
    r RECORD;
    idx_sql TEXT;
BEGIN
    FOR r IN
        SELECT relname
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relkind = 'r'
          AND relname LIKE 'fact_orders_%'    -- matches child partitions we created
    LOOP
        -- customer_key index
        idx_sql := format($$
            DO $inner$
            BEGIN
                IF NOT EXISTS (
                    SELECT 1 FROM pg_class WHERE relname = %L
                ) THEN
                    EXECUTE %L;
                END IF;
            END
            $inner$;
            $$,
            'idx_' || r.relname || '_customer',
            'CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_' || r.relname || '_customer ON ' || r.relname || ' (customer_key)'
        );
        EXECUTE idx_sql;

        -- product_key index
        idx_sql := format($$
            DO $inner$
            BEGIN
                IF NOT EXISTS (
                    SELECT 1 FROM pg_class WHERE relname = %L
                ) THEN
                    EXECUTE %L;
                END IF;
            END
            $inner$;
            $$,
            'idx_' || r.relname || '_product',
            'CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_' || r.relname || '_product ON ' || r.relname || ' (product_key)'
        );
        EXECUTE idx_sql;

        -- invoice_date index (often redundant with partitioning but useful for some plans)
        idx_sql := format($$
            DO $inner$
            BEGIN
                IF NOT EXISTS (
                    SELECT 1 FROM pg_class WHERE relname = %L
                ) THEN
                    EXECUTE %L;
                END IF;
            END
            $inner$;
            $$,
            'idx_' || r.relname || '_invdate',
            'CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_' || r.relname || '_invdate ON ' || r.relname || ' (invoice_date)'
        );
        EXECUTE idx_sql;

        -- invoice_no index
        idx_sql := format($$
            DO $inner$
            BEGIN
                IF NOT EXISTS (
                    SELECT 1 FROM pg_class WHERE relname = %L
                ) THEN
                    EXECUTE %L;
                END IF;
            END
            $inner$;
            $$,
            'idx_' || r.relname || '_invno',
            'CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_' || r.relname || '_invno ON ' || r.relname || ' (invoice_no)'
        );
        EXECUTE idx_sql;

        -- Example covering index (invoice_date, customer_key) to help common dashboards:
        idx_sql := format($$
            DO $inner$
            BEGIN
                IF NOT EXISTS (
                    SELECT 1 FROM pg_class WHERE relname = %L
                ) THEN
                    EXECUTE %L;
                END IF;
            END
            $inner$;
            $$,
            'idx_' || r.relname || '_invdate_cust_cover',
            'CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_' || r.relname || '_invdate_cust_cover ON ' || r.relname || ' (invoice_date, customer_key)'
        );
        EXECUTE idx_sql;

    END LOOP;
END
$$;

-- Run ANALYZE on partitions once indexes are created
ANALYZE fact_orders_2010;
ANALYZE fact_orders_2011;
ANALYZE fact_orders_older;
ANALYZE fact_orders_future;
