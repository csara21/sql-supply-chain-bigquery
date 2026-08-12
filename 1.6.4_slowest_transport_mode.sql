WITH new_shipment_clean AS (
  
SELECT
c.shipment_id,
c.carrier_id,
cl.delivery_time_days

FROM `project-66ce65a0-526a-4358-951.supply_chain_one.shipments_clean` cl
LEFT JOIN `project-66ce65a0-526a-4358-951.supply_chain_one.shipments`c
ON c.shipment_id = cl.shipment_id


)


SELECT 

cr.transport_mode,
-- new_shipment_clean.carrier_id,
ROUND (AVG(new_shipment_clean.delivery_time_days),2)as avg_delivery_time_days,
COUNT(new_shipment_clean.shipment_id) AS total_shipments


FROM new_shipment_clean
LEFT JOIN `project-66ce65a0-526a-4358-951.supply_chain_one.carriers_clean` cr
ON new_shipment_clean.carrier_id = cr.carrier_id
WHERE new_shipment_clean.delivery_time_days IS NOT NULL
GROUP BY cr.transport_mode
ORDER BY avg_delivery_time_days DESC

