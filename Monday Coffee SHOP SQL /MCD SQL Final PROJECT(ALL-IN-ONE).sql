# MCD SQL Final PROJECT(ALL-IN-ONE) #

CREATE DATABASE mcd; -- create database to start
USE mcd; -- this stage we define system to use the database we created to use

# Activity 1: Data Loading

/*1. How do you create the tables for customers, products, and sales in the database?*/

CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city_id INT
    );
    
CREATE TABLE products(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity VARCHAR(100)
);

CREATE TABLE city(
	city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100),
    population INT NOT NULL,
    estimated_rent DECIMAL(10,2) NOT NULL,
    city_rank INT NOT NULL
);

CREATE TABLE sales(
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    product_id INT,
    quantity INT,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    rating INT
);

# Activity 2: Data Cleaning & Preprocessing

/* 2. How can you identify null values in your dataset?*/

USE mcd;

SELECT 
    'customers' as table_name,
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) as null_customer_id,
    COUNT(CASE WHEN customer_name IS NULL THEN 1 END) as null_customer_name,
    COUNT(CASE WHEN city_id IS NULL THEN 1 END) as null_city_id
FROM customers;

SELECT 
    'products' as table_name,
    COUNT(CASE WHEN product_id IS NULL THEN 1 END) as null_product_id,
    COUNT(CASE WHEN product_name IS NULL THEN 1 END) as null_product_name,
    COUNT(CASE WHEN price IS NULL THEN 1 END) as null_price,
    COUNT(CASE WHEN quantity IS NULL THEN 1 END) as null_quantity
FROM products;

SELECT 
    'city' as table_name,
    COUNT(CASE WHEN city_id IS NULL THEN 1 END) as null_city_id,
    COUNT(CASE WHEN city_name IS NULL THEN 1 END) as null_city_name,
    COUNT(CASE WHEN population IS NULL THEN 1 END) as null_population,
    COUNT(CASE WHEN estimated_rent IS NULL THEN 1 END) as null_estimated_rent,
    COUNT(CASE WHEN city_rank IS NULL THEN 1 END) as null_city_rank
FROM city;

/*How can you check for duplicate entries in the customers table?*/

/*CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city_id INT
    );*/
    
SELECT customer_name, COUNT(*)
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;

/*How do you check for mismatches between total_amount and the calculated value of price × quantity? */

SELECT
	s.sale_id,
    s.total_amount AS recorded_total,
    (p.price * s.quantity) AS calculated_total,
    ABS(s.total_amount - (p.price * s.quantity)) AS difference
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE ABS(s.total_amount - (p.price * s.quantity)) > 0.01;

#Activity 3: Data Transformation & Integration

/* How do you create a comprehensive sales report with customer and product details?*/
SELECT 
    s.sale_id,
    s.sale_date,
    c.customer_name,
    p.product_name,
    s.quantity,
    p.price,
    s.total_amount,
    s.rating
FROM sales s
	JOIN customers c ON s.customer_id = c.customer_id
	JOIN products p ON s.product_id = p.product_id
ORDER BY s.sale_date DESC;

#Activity 4: Data Analysis & Aggregation

/* What are the total sales per city?*/
 SELECT 
    city.city_name,
    SUM(s.total_amount) AS total_sales,
    COUNT(s.sale_id) AS number_of_orders,
    AVG(s.total_amount) AS average_order_value
FROM sales s
	JOIN customers c ON s.customer_id = c.customer_id
	JOIN city ON c.city_id = city.city_id
GROUP BY city.city_id, city.city_name
ORDER BY total_sales DESC;

/* How many total transactions occurred per city?*/

SELECT 
    city.city_name,
    COUNT(s.sale_id) AS total_transactions
FROM city
	LEFT JOIN customers c ON city.city_id = c.city_id
	LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY city.city_id, city.city_name
ORDER BY total_transactions DESC;

/* How many unique customers are there in each city? */

SELECT 
    city.city_name,
    COUNT(DISTINCT c.customer_id) AS unique_customers
FROM city
	LEFT JOIN customers c ON city.city_id = c.city_id
GROUP BY city.city_id, city.city_name
ORDER BY unique_customers DESC;

/* What is the average order value per city? */

SELECT 
    city.city_name,
    COUNT(s.sale_id) AS total_orders,
    COALESCE(SUM(s.total_amount), 0) AS total_sales,
    COALESCE(AVG(s.total_amount), 0) AS average_order_value
FROM city
	LEFT JOIN customers c ON city.city_id = c.city_id
	LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY city.city_id, city.city_name
HAVING COUNT(s.sale_id) > 0
ORDER BY average_order_value DESC;

/* What is the demand for each product in different cities? */

SELECT 
    city.city_name,
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold,
    COUNT(s.sale_id) AS number_of_orders,
    SUM(s.total_amount) AS total_revenue
FROM sales s
	JOIN customers c ON s.customer_id = c.customer_id
	JOIN city ON c.city_id = city.city_id
	JOIN products p ON s.product_id = p.product_id
GROUP BY city.city_id, city.city_name, p.product_id, p.product_name
ORDER BY city.city_name, total_quantity_sold DESC;

/* What is the monthly sales trend? */

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    COUNT(sale_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM sales
WHERE sale_date IS NOT NULL
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

/* What is the average product rating per city based on customer purchases? */

SELECT 
    city.city_name,
    AVG(s.rating) AS average_rating
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN city ON c.city_id = city.city_id
WHERE s.rating IS NOT NULL
GROUP BY city.city_id, city.city_name
ORDER BY average_rating DESC;

# Activity 5: Decision-Making & Recommendations

  /* How do you identify the top 3 cities based on sales, unique customers, and order count?*/

SELECT 
    city.city_name,
    SUM(sales.total_amount) AS total_sales,
    COUNT(DISTINCT customers.customer_id) AS unique_customers,
    COUNT(sales.sale_id) AS order_count
FROM city
	JOIN customers ON city.city_id = customers.city_id
	JOIN sales ON customers.customer_id = sales.customer_id
GROUP BY city.city_id, city.city_name
ORDER BY total_sales DESC, unique_customers DESC, order_count DESC
LIMIT 3;

# Monday Coffee Expansion Recommendations

#1. Prioritize New York for immediate expansion with 2-3 new locations due to highest sales and customer density

#2. Expand in Los Angeles with 1-2 strategic locations as secondary high-priority market

#3. Open one flagship store in Chicago to strengthen presence in third-ranked market

#4. Target high-foot traffic areas in commercial districts and business centers

#5. Maintain product quality consistency across all new locations to preserve high customer ratings

#6. Implement loyalty programs in existing markets to increase customer retention

#7. Focus on cities with high population density but currently low market penetration

#8. Consider Boston and Miami for future expansion as untapped markets

#9. Optimize average order value through strategic upselling and premium product placement

#10. Use customer rating data to maintain service quality standards in new locations

#11. Phase expansion over 18 months starting with New York, then LA, then Chicago

#12. Monitor monthly sales trends to time new store openings during peak seasons

#13. Leverage high-performing product data to inform menu planning in new locations

#14. Balance expansion between strengthening existing markets and entering new ones

#15. Allocate marketing budget proportional to each city's growth potential and current performance

