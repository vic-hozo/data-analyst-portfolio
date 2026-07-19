-- ==========================================
-- 03_business_questions.sql
-- ==========================================

-- Top 10 customers by sales
-- Purpose: Identify the highest-value customers for retention and marketing efforts.

SELECT customer_name, 
	ROUND(SUM(sales),2) as total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 products by sales
-- Purpose: Understand best-selling products for inventory and marketing decisions.

SELECT product_name, 
	ROUND(SUM(sales),2) as total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 5 states by profit
-- Purpose: Find the most profitable markets and understand where the business performs best.

SELECT state, 
	ROUND(SUM(profit),2) as total_profit
FROM orders
GROUP BY state
ORDER BY total_profit DESC
LIMIT 5;

-- Monthly sales trend
-- Purpose: Analyze sales performance over time to identify seasonality or growth trends.

SELECT
    substr(order_date, -4) || '-' ||
    printf('%02d', CAST(substr(order_date, 1, instr(order_date, '/') - 1) AS INTEGER)) AS year_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY year_month
ORDER BY year_month;

-- Least profitable sub-categories
-- Purpose: Identify underperforming product lines that may need pricing, cost, or inventory adjustments.

SELECT sub_category,
	ROUND(SUM(profit),2) as total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit ASC
LIMIT 5;SELECT sub_category,
	ROUND(SUM(profit),2) as total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit ASC
LIMIT 5;

-- Sales vs. Profit by category
-- Compare sales and profit across product categories to determine which categories generate the most revenue and which are the most profitable.

SELECT category,
	ROUND(SUM(sales),2) as total_sales,
	ROUND(SUM(profit),2) as total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;

