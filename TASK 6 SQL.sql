SHOW DATABASES;
USE ONLINE_SALES;

-- Step 2: Create 'orders' Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

-- Step 3: Insert Sample Data
INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
(1, '2023-01-10', 1500.00, 101),
(2, '2023-01-15', 2500.50, 102),
(3, '2023-02-05', 3000.00, 103),
(4, '2023-02-18', 1750.75, 101),
(5, '2023-03-01', 2200.00, 104),
(6, '2023-03-22', 3300.00, 105),
(7, '2023-04-05', 2100.00, 102),
(8, '2023-04-10', 1800.50, 103),
(9, '2023-05-01', 2500.00, 104),
(10, '2023-05-12', 2750.25, 105);

select * FROM orders;

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    orders
WHERE
    order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    order_year, order_month;



--  2. Top 5 Months by Revenue
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS revenue
FROM
    orders
GROUP BY year, month
ORDER BY revenue DESC
LIMIT 5;


--  3. Total Orders and Revenue per Year
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(amount) AS total_revenue
FROM
    orders
GROUP BY order_year
ORDER BY order_year;


-- 🔹 4. Product-wise Sales (Total Revenue per Product)
SELECT
    product_id,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(amount) AS total_revenue
FROM
    orders
GROUP BY product_id
ORDER BY total_revenue DESC;



-- 5. Daily Sales Trend for Last 30 Days
SELECT
    order_date,
    SUM(amount) AS daily_revenue,
    COUNT(DISTINCT order_id) AS daily_orders
FROM
    orders
WHERE
    order_date >= CURRENT_DATE - INTERVAL '30' DAY
GROUP BY order_date
ORDER BY order_date DESC;


--  6. Average Order Value Per Month
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    ROUND(SUM(amount)::numeric / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM
    orders
GROUP BY year, month
ORDER BY year, month;