/*How do you create the tables for customers, products, and sales in the database?*/

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