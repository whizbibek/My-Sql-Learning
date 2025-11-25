/* What is the monthly sales trend? */

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    COUNT(sale_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM sales
WHERE sale_date IS NOT NULL
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;