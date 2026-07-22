-- ==========================================
-- 04_advanced_sql.sql
-- ==========================================

-- CASE with subquery
-- Customer segmentation
-- Identify high-value customers for retention and loyalty programs, while helping the business understand which customers may need targeted marketing or promotional strategies.

SELECT 
	customer_name,
	total_spent,
	CASE
	WHEN total_spent >= 5000 THEN 'High Value'
	WHEN total_spent >= 2000 THEN 'Medium Value'
	ELSE 'Low Value'
	END customer_category
FROM (
	SELECT 
		customer_name,
		ROUND(SUM(sales),2) as total_spent
	FROM orders
	GROUP BY customer_name
	) as customer_total;
	
	