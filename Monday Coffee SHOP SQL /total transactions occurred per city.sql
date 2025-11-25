/* How many total transactions occurred per city?*/

SELECT 
    city.city_name,
    COUNT(s.sale_id) AS total_transactions
FROM city
	LEFT JOIN customers c ON city.city_id = c.city_id
	LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY city.city_id, city.city_name
ORDER BY total_transactions DESC;