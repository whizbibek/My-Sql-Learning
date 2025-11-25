/* How can you identify null values in your dataset?*/

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