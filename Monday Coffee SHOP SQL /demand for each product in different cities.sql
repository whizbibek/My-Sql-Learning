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