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