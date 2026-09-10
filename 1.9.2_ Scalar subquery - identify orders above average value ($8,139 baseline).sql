SELECT

order_id, 
total_value_usd

FROM `supply_chain_one.orders_clean`


GROUP BY order_id, total_value_usd

HAVING total_value_usd > (SELECT AVG(total_value_usd) FROM `supply_chain_one.orders_clean`)

ORDER BY total_value_usd DESC

LIMIT 1000
