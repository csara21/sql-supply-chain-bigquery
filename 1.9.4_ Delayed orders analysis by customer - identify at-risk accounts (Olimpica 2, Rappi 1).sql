WITH delayed_orders AS (
  
SELECT
o.customer_id,
COUNT  (IF (s.delivery_status = 'DELAYED',1,NULL)) AS delayed_orders

FROM `supply_chain_one.shipments_clean`s
LEFT JOIN  `supply_chain_one.orders_clean`o
ON s.order_id = o.order_id

GROUP BY o.customer_id

)

SELECT 
c.customer_name,
COALESCE(d.delayed_orders,0) AS delayed_orders_total
FROM `supply_chain_one.customers`c
LEFT JOIN delayed_orders d
ON c.customer_id = d.customer_id



ORDER BY delayed_orders_total DESC