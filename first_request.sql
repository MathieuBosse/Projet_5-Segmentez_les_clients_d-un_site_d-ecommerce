-- En excluant les commandes annulées, quelles sont les commandes
-- récentes de moins de 3 mois que les clients ont reçues avec au moins 3
-- jours de retard ?

SELECT
    order_id,
    DATE(order_purchase_timestamp) AS purchase,
    DATE(order_estimated_delivery_date) AS estimated_delivery,
    DATE(order_delivered_customer_date) AS actual_delivery

FROM
    orders
WHERE
    order_status != 'canceled' -- Excluant les commandes annulées
    AND DATETIME(order_purchase_timestamp) >= DATETIME('2018-10-17 17:30:18', '-3 months')
    AND julianday(DATETIME(order_delivered_customer_date)) >= julianday(DATETIME(order_estimated_delivery_date)) + 3;