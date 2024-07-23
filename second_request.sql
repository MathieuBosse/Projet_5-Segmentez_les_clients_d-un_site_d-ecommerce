-- Qui sont les vendeurs ayant généré un chiffre d'affaires de plus de 100
-- 000 Real sur des commandes livrées via Olist ?


SELECT
    seller_id, SUM(price) as total_revenue_seller
FROM
    order_items
JOIN
    orders on order_items.order_id = orders.order_id
WHERE 
    orders.order_status = 'delivered'
GROUP BY 
    seller_id
HAVING 
    total_revenue_seller > 100000;