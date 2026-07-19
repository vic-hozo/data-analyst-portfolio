-- ==========================================
-- 02_exploratory_analysis.sql
-- ==========================================

-- Overall KPIs (orders, sales, profit, average sales)
SELECT 
	ROUND(SUM(sales),2) as total_sales, 
	ROUND(SUM(profit),2) as total_profit, 
	ROUND(AVG(sales),2) as average_sales
FROM orders;

-- Sales by category
SELECT category, 
	ROUND(SUM(sales),2) as total_sales_per_category
FROM orders
GROUP BY category
ORDER BY total_sales_per_category  DESC;

-- Profit by category
SELECT category, 
	ROUND(SUM(profit),2) as total_profit_per_category
FROM orders
GROUP BY category
ORDER BY total_profit_per_category DESC;

-- Sales by region
SELECT region, 
	ROUND(SUM(sales),2) as total_sales_per_region
FROM orders
GROUP BY region
ORDER BY total_sales_per_region DESC;

-- Sales by segment
SELECT segment, 
	ROUND(SUM(sales),2) as total_sales_per_segment
FROM orders
GROUP BY segment
ORDER BY total_sales_per_segment DESC;