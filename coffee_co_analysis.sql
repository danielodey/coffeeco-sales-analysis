USE coffee_co;

SELECT * FROM city;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sales;

SELECT MAX(sale_date), MIN(sale_date) FROM sales;
SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM city;
SELECT COUNT(*) FROM customers;

-- Sales Performance Overview
-- 1a) Find the total sales

SELECT SUM(total) FROM sales;

-- 1b) find average rating
SELECT ROUND(AVG(rating), 0) AS average_rating FROM sales;

-- Customer and City Analysis
-- 2) Determine the top 3 cities with the highest number of customers

SELECT ci.city_name, COUNT(cu.customer_name) AS customer_count
FROM customers AS cu
INNER JOIN city AS ci
ON cu.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY customer_count DESC
LIMIT 3;

-- Product Performance
-- 3a) top 5 best selling products

SELECT p.product_name, SUM(s.total) AS total_sales
FROM sales AS s
INNER JOIN products AS p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 5;

-- 3b) product(s) with an average rating below 3
SELECT p.product_name, AVG(s.rating) AS average_rating 
FROM sales AS s
INNER JOIN products AS p
ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING average_rating < 3;

-- Customer Segmentation and Revenue
-- 4a) Find the total revenue per city, showing only cities with revenue above INR200,000.

-- introduce a bridge table
SELECT * FROM city;
SELECT * FROM customers;
SELECT * FROM sales;
SELECT * FROM products;

SELECT ci.city_name, SUM(s.total) AS total_sales
FROM city AS ci
INNER JOIN customers AS cu
ON ci.city_id = cu.city_id
INNER JOIN sales AS s
ON cu.customer_id = s.customer_id
GROUP BY ci.city_name
HAVING total_sales > 200000
ORDER BY total_sales DESC;

-- 4b) Retrieve customers who have made at least 50 purchases
WITH cus_sales AS (SELECT c.customer_name, COUNT(s.sale_id) AS total_purchases
FROM customers AS c
INNER JOIN sales AS s
ON c.customer_id = s.customer_id
GROUP BY c.customer_name
HAVING total_purchases >= 50
ORDER BY total_purchases DESC)

SELECT * FROM cus_sales;

/* 5) Identify the customer who has spent the most money overall. 
	Return the name of the customer and their total spend
*/
SELECT c.customer_name, SUM(s.total) AS total_spent
FROM customers c
INNER JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;











