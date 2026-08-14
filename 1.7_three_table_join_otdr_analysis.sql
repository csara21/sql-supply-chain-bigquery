SELECT

W.region,
Count(O.order_id) AS total_shipments,
COUNT (CASE WHEN S.delivery_status = "ON TIME" THEN 1 END) AS total_on_time_shipments,

ROUND (SAFE_DIVIDE(COUNT (CASE WHEN S.delivery_status = 'ON TIME' THEN 1 END),Count(O.order_id))*100,2) AS `otdr_percentage`

-- COUNT(CASE WHEN salario > 3000 THEN 1 END) AS empleados_altos_ingresos,

FROM `project-66ce65a0-526a-4358-951.supply_chain_one.orders_clean` O
LEFT JOIN `project-66ce65a0-526a-4358-951.supply_chain_one.shipments_clean` S
ON O.order_id = S.order_id

LEFT JOIN `supply_chain_one.warehouses`W
ON  O.warehouse_id = W.warehouse_id

GROUP BY W.region
ORDER BY total_shipments DESC

