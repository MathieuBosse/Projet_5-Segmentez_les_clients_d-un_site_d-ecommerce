-- Quels sont les 5 codes postaux, enregistrant plus de 30 commandes,
-- avec le pire review score moyen sur les 12 derniers mois ?

SELECT 
    c.customer_zip_code_prefix, 
    COUNT(o.order_id) as total_orders_by_zip_code, 
    AVG(orev.review_score) as average_review_score
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    order_reviews orev ON o.order_id = orev.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    c.customer_zip_code_prefix
HAVING 
    total_orders_by_zip_code > 30
ORDER BY 
    average_review_score ASC
LIMIT 5;
