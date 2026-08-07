SELECT
sc.shipment_id,
s.carrier_id,
sc.order_id,
sc.distance_km,
sc.scheduled_date,
sc.actual_delivery_date,
sc.delivery_status,
sc.delivery_time_days



 FROM `project-66ce65a0-526a-4358-951.supply_chain_one.shipments_clean` sc
 LEFT JOIN `project-66ce65a0-526a-4358-951.supply_chain_one.shipments` s

 ON sc.shipment_id = s.shipment_id;