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