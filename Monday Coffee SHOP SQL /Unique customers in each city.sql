/* How many unique customers are there in each city? */

SELECT 
    city.city_name,
    COUNT(DISTINCT c.customer_id) AS unique_customers
FROM city
	LEFT JOIN customers c ON city.city_id = c.city_id
GROUP BY city.city_id, city.city_name
ORDER BY unique_customers DESC;