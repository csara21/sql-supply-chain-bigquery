

WITH high_value_orders AS (

SELECT 
order_id,
total_value_usd
FROM `supply_chain_one.orders_clean`
GROUP BY order_id,total_value_usd
HAVING total_value_usd > (SELECT AVG(total_value_usd) FROM `supply_chain_one.orders_clean`)
)


SELECT
c.customer_name,
MAX(o.order_date) AS Lasted_order_date,
MIN(o.order_date) AS First_order_date,
SUM (o.total_value_usd) AS total_amount_bought,
COUNT (o.order_id) AS numver_of_orders
FROM `supply_chain_one.orders_clean`o


LEFT JOIN `supply_chain_one.customers` c
 ON o.customer_id = c.customer_id
LEFT JOIN high_value_orders h
 ON o.order_id = h.order_id

WHERE o.order_id IN (SELECT order_id FROM high_value_orders)

GROUP BY customer_name
ORDER BY total_amount_bought DESC



