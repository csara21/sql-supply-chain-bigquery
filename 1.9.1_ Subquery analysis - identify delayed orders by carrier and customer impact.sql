



-- Subquery approach (Fix: using orders_clean since carriers_clean lacks order_id)

-- SELECT
-- o.customer_id,
-- c.customer_name,
-- o.order_id,
-- o.status

WITH oders_delayed AS (
SELECT*
FROM `supply_chain_one.orders_clean` o
WHERE
  o.order_id IN (
    SELECT order_id
    FROM `supply_chain_one.shipments_clean`
    WHERE delivery_status = 'DELAYED'
  )
)
SELECT

sc.carrier_id,
ca.carrier_name,
c.customer_name,
sc.delivery_Status,
AVG(DATE_DIFF(s.actual_delivery_date,s.scheduled_date,DAY)) AS AVG_Delay_days,
SUM(o.total_value_usd) as total_value_usd,
COUNT(o.order_id) as total_orders

FROM oders_delayed o
LEFT JOIN `supply_chain_one.customers` c
 ON o.customer_id = c.customer_id
LEFT JOIN `supply_chain_one.shipments_clean` s
 ON o.order_id = s.order_id
 LEFT JOIN `supply_chain_one.shipments`sc
 ON o.order_id = sc.order_id
LEFT JOIN `supply_chain_one.carriers` ca
 ON sc.carrier_id = ca.carrier_id

WHERE sc.delivery_Status = "DELAYED"

GROUP BY ca.carrier_name,sc.carrier_id,c.customer_name,sc.delivery_Status

