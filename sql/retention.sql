-- Purpose: Identify new vs repeat customers

WITH first_purchase AS (
    SELECT 
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_purchase
    FROM orders o
    JOIN customers c
    ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS month,
    CASE 
        WHEN o.order_purchase_timestamp = f.first_purchase THEN 'New'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(DISTINCT c.customer_unique_id) AS users
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN first_purchase f
ON c.customer_unique_id = f.customer_unique_id
GROUP BY month, customer_type
ORDER BY month, customer_type;
