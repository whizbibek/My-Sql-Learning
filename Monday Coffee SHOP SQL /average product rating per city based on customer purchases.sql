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