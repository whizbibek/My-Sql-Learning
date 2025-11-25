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