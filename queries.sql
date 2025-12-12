-- ============================================================
-- Retail Sales Analytics Project 
-- Dataset tables: orders, sales, products
-- Run each section separately in MySQL Workbench.
-- ============================================================


/* ============================================================
   0) INSPECT TABLES (safe)
   ============================================================ */


SELECT * FROM orders LIMIT 5;
SELECT * FROM sales LIMIT 5;
SELECT * FROM products LIMIT 5;



/* ============================================================
   1) DUPLICATE CHECKS (does NOT modify data)
   ============================================================ */

-- 1.1 Duplicate order_id in orders (should be zero)
SELECT order_id, COUNT(*) AS dup_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 1.2 Duplicate (order_id, product_name) in sales
SELECT order_id, product_name, COUNT(*) AS dup_count
FROM sales
GROUP BY order_id, product_name
HAVING COUNT(*) > 1;

-- 1.3 Duplicate product_name in products
SELECT product_name, COUNT(*) AS dup_count
FROM products
GROUP BY product_name
HAVING COUNT(*) > 1;



/* ============================================================
   2) DELETE DUPLICATES IN SALES (run ONLY if above returns rows)
   ============================================================ */

-- 2.1 Backup table before deleting
CREATE TABLE IF NOT EXISTS sales_backup AS SELECT * FROM sales;

-- 2.2 Delete only TRUE duplicates: keep MIN(sale_id)
DELETE FROM sales
WHERE sale_id NOT IN (
    SELECT * FROM (
        SELECT MIN(sale_id)
        FROM sales
        GROUP BY order_id, product_name
    ) AS keep_rows
);



/* ============================================================
   3) DATE RANGE CHECK (orders.order_date is already DATE)
   ============================================================ */

SELECT MIN(order_date) AS earliest_order_date,
       MAX(order_date) AS latest_order_date
FROM orders;



/* ============================================================
   4) KPI QUERIES (compare with Power BI cards)
   ============================================================ */

-- Total Sales
SELECT ROUND(SUM(sales),2) AS total_sales
FROM sales;

-- Total Distinct Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM sales;

-- Total Profit
SELECT ROUND(SUM(profit),2) AS total_profit
FROM sales;

-- Average Order Value (AOV)
SELECT ROUND(SUM(sales) / NULLIF(COUNT(DISTINCT order_id),0),2) AS avg_order_value
FROM sales;



/* ============================================================
   5) REGION / STATE / CITY ANALYSIS
   ============================================================ */

-- Sales by Region
SELECT o.region, ROUND(SUM(s.sales),2) AS total_sales
FROM sales s
JOIN orders o ON s.order_id = o.order_id
GROUP BY o.region
ORDER BY total_sales DESC;

-- Sales by State
SELECT o.state, ROUND(SUM(s.sales),2) AS total_sales
FROM sales s
JOIN orders o ON s.order_id = o.order_id
GROUP BY o.state
ORDER BY total_sales DESC
LIMIT 20;

-- Sales by City
SELECT o.city, ROUND(SUM(s.sales),2) AS total_sales
FROM sales s
JOIN orders o ON s.order_id = o.order_id
GROUP BY o.city
ORDER BY total_sales DESC
LIMIT 30;



/* ============================================================
   6) MONTHLY SALES TREND
   ============================================================ */

SELECT DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start,
       ROUND(SUM(s.sales),2) AS monthly_sales
FROM sales s
JOIN orders o ON s.order_id = o.order_id
GROUP BY month_start
ORDER BY month_start;



/* ============================================================
   7) CATEGORY / SUBCATEGORY / TOP PRODUCTS
   ============================================================ */

-- Category-wise Sales
SELECT COALESCE(p.category,'UNKNOWN') AS category,
       ROUND(SUM(s.sales),2) AS total_sales
FROM sales s
LEFT JOIN products p 
  ON LOWER(TRIM(s.product_name)) = LOWER(TRIM(p.product_name))
GROUP BY category
ORDER BY total_sales DESC;


-- Subcategory-wise Sales
SELECT COALESCE(p.sub_category,'UNKNOWN') AS sub_category,
       ROUND(SUM(s.sales),2) AS total_sales
FROM sales s
LEFT JOIN products p 
  ON LOWER(TRIM(s.product_name)) = LOWER(TRIM(p.product_name))
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 20;


-- Top 20 Products by Sales
SELECT s.product_name,
       ROUND(SUM(s.sales),2) AS total_sales,
       SUM(s.quantity) AS total_quantity
FROM sales s
GROUP BY s.product_name
ORDER BY total_sales DESC
LIMIT 20;



/* ============================================================
   8) TOP CUSTOMERS + CUSTOMER FREQUENCY
   ============================================================ */

-- Top Customers by Revenue
SELECT o.customer_name,
       ROUND(SUM(s.sales),2) AS total_sales,
       COUNT(DISTINCT s.order_id) AS order_count
FROM sales s
JOIN orders o ON s.order_id = o.order_id
GROUP BY o.customer_name
ORDER BY total_sales DESC
LIMIT 20;

-- Customer Frequency Distribution
SELECT order_count, COUNT(*) AS num_customers
FROM (
    SELECT o.customer_name,
           COUNT(DISTINCT s.order_id) AS order_count
    FROM sales s
    JOIN orders o ON s.order_id = o.order_id
    GROUP BY o.customer_name
) AS t
GROUP BY order_count
ORDER BY order_count DESC;



/* ============================================================
   9) DISCOUNT + PROFIT MARGIN METRICS
   ============================================================ */

-- Total Discount Given
SELECT ROUND(SUM(discount),2) AS total_discount
FROM sales;

-- Profit Margin (%)
SELECT ROUND(SUM(profit) / NULLIF(SUM(sales),0) * 100,2) AS profit_margin_pct
FROM sales;



/* ============================================================
   10) FINAL VIEW FOR POWER BI (use this for reporting)
   ============================================================ */

CREATE OR REPLACE VIEW vw_sales_orders AS
SELECT
    s.sale_id,
    s.order_id,
    o.order_date,
    o.ship_date,
    o.customer_name,
    o.city,
    o.state,
    o.region,
    s.product_name,
    COALESCE(p.category,'UNKNOWN') AS category,
    COALESCE(p.sub_category,'UNKNOWN') AS sub_category,
    s.quantity,
    s.sales,
    s.profit,
    s.discount
FROM sales s
LEFT JOIN orders o 
  ON s.order_id = o.order_id
LEFT JOIN products p 
  ON LOWER(TRIM(s.product_name)) = LOWER(TRIM(p.product_name));



/* ============================================================
   11) VALIDATION QUERIES (run before presenting)
   ============================================================ */

-- Count rows
SELECT COUNT(*) AS sales_rows FROM sales;

-- Unique Orders
SELECT COUNT(DISTINCT order_id) AS unique_orders FROM sales;

-- Date range
SELECT MIN(order_date) AS earliest_date, MAX(order_date) AS latest_date
FROM orders;
