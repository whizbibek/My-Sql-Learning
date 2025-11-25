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