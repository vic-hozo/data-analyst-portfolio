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

-- CTE, CROSS JOIN, Aggregate
-- Above-Average Customers
-- Purpose: Identified customers whose total sales exceeded the average customer spending, helping highlight high-value customers for targeted retention and marketing strategies.


WITH total_per_customer  as (
	-- Calculate the  total sales for each customer
	SELECT customer_name,
	ROUND(SUM(sales),2) total_sales
	FROM orders
	GROUP BY customer_name
	) ,
	-- Calculate the total_average of the 
 total_avg as (
	SELECT
	ROUND(AVG(total_sales),2) as total_average
	FROM total_per_customer
	)
	
SELECT 
	tpc.customer_name,
	tpc.total_sales
	FROM total_per_customer as tpc
	CROSS JOIN total_avg as tag 
	WHERE tpc.total_sales > tag.total_average


-- CTE
-- Monthly Sales Trend
-- Purpose: Analyzed monthly sales performance over time to identify changes and patterns in sales activity.

WITH monthly_sales as (
    -- Calculate total sales for each month
    SELECT
        substr(order_date, -4) || '-' ||
        printf(
            '%02d',
            CAST(
                substr(order_date, 1, instr(order_date, '/') - 1)
                as INTEGER
            )
        ) as year_month,
        ROUND(SUM(sales), 2) as total_sales
    FROM orders
    GROUP BY year_month
)

-- Display the monthly sales trend
SELECT
    year_month,
    total_sales
FROM monthly_sales
ORDER BY year_month;
