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
	
-- Windows Function. RANK(), PARTITION BY, subquery
-- Top Customer in Each Region
-- Purpose: Identify the highest-spending customer in every region.

SELECT *
FROM
(
    -- Rank customers within each region based on their total sales
    SELECT
        customer_name,
        region,
        ROUND(total_sales, 2) as total_sales,
        -- Assign a rank to each customer within their region.
        -- Ranking starts again at 1 for each region.
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) as sales_rank

    FROM
    (
        -- Calculate the total sales for each customer in each region
        SELECT
            customer_name,
            region,
            SUM(sales) as total_sales
        FROM orders
        -- Group the sales by customer and region
        GROUP BY customer_name, region

    ) as customer_sales

) as overall
-- Only display customers ranked 1st, 2nd, or 3rd
WHERE sales_rank <= 3;


