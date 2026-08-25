SELECT
  
  O.order_id, 
  sh.freight_cost_usd,
  O.total_value_usd,
  DATE_DIFF (S.actual_delivery_date,S.scheduled_date,     DAY) AS delivery_delay_days,
  O.status,
  W.region


FROM `project-66ce65a0-526a-4358-951.supply_chain_one.orders_clean` O
LEFT JOIN `project-66ce65a0-526a-4358-951.supply_chain_one.shipments_clean` S
ON O.order_id = S.order_id

LEFT JOIN `supply_chain_one.warehouses`W
ON  O.warehouse_id = W.warehouse_id

LEFT JOIN `supply_chain_one.customers`C
ON O.customer_id = C.customer_id


LEFT JOIN `supply_chain_one.shipments`sh
ON S.shipment_id = sh.shipment_id

LEFT JOIN `supply_chain_one.carriers`ca
ON sh.carrier_id = ca.carrier_id

ORDER BY freight_cost_usd

