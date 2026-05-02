-- Purpose: Calculate monthly revenue trend

SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS revenue
FROM orders o
JOIN order_payments p
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;
