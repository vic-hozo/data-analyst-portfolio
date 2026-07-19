-- ==========================================
-- 01_data_validation.sql
-- ==========================================

-- Total rows
SELECT 
	COUNT(*) as  total_rows
FROM orders;

-- Preview data
SELECT *
FROM orders 
order by order_id
LIMIT 10;

-- Check NULL values (checked order_id, customer_id, product_id, sales, profit)
SELECT *
FROM orders
WHERE order_id IS NULL;

-- Check duplicate IDs
SELECT row_id, 
	COUNT(*) as occurences
FROM orders 
GROUP BY row_id
HAVING occurences > 1;

-- Check distinct categories and regions
SELECT DISTINCT category, region
FROM orders;
