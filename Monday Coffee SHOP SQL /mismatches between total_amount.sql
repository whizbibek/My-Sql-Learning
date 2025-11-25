/*How do you check for mismatches between total_amount and the calculated value of price × quantity? */

SELECT
	s.sale_id,
    s.total_amount AS recorded_total,
    (p.price * s.quantity) AS calculated_total,
    ABS(s.total_amount - (p.price * s.quantity)) AS difference
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE ABS(s.total_amount - (p.price * s.quantity)) > 0.01;