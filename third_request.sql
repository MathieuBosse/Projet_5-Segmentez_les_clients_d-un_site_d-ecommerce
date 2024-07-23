-- Qui sont les nouveaux vendeurs (moins de 3 mois d'ancienneté) qui
--sont déjà très engagés avec la plateforme (ayant déjà vendu plus de 30
-- produits) ?

WITH NewSellers AS (
    SELECT 
        seller_id, 
        won_date
    FROM 
        leads_closed
    WHERE 
        DATETIME(won_date) >= DATETIME('2018-10-17 17:30:18', '-3 months')
),
SellerSales AS (
    SELECT
        oi.seller_id,
        COUNT(oi.order_item_id) AS total_products_sold
    FROM
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    JOIN 
        sellers s ON oi.seller_id = s.seller_id
    WHERE
        o.order_status = 'delivered'
    GROUP BY
        oi.seller_id
)
SELECT
    ns.seller_id,
    ns.closure_date,
    ss.total_products_sold
FROM
    NewSellers ns
JOIN
    SellerSales ss ON ns.seller_id = ss.seller_id
WHERE
    ss.total_products_sold > 30;