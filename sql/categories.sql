-- Purpose: Identify top revenue-generating product categories

SELECT 
    ct.product_category_name_english AS category,
    SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;
