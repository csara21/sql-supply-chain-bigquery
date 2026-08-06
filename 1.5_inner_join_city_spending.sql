WITH data_inner_join AS(
SELECT
o.order_id,
o.customer_id,
o.warehouse_id,
o.order_date,
o.total_value_usd,
o.status,
o.priority,
c.city,
c.country

 FROM`project-66ce65a0-526a-4358-951.supply_chain_one.orders` o
 INNER JOIN `project-66ce65a0-526a-4358-951.supply_chain_one.customers` c
 ON o.customer_id = c.customer_id
)

SELECT 
  city,
  SUM(total_value_usd) AS sum_total_value_usd,
  COUNT(*) AS total_orders,
  ROUND(
    (SUM(total_value_usd) / SUM(SUM(total_value_usd)) OVER()) * 100, 
    2
  ) AS percentage_of_total

FROM data_inner_join
GROUP BY city
ORDER BY sum_total_value_usd DESC
LIMIT 5;