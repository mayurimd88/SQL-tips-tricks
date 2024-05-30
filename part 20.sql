use tips;

SELECT s.product_id AS stock_pid, s.stock_quantity, p.product_id, p.cost
FROM stock s
LEFT JOIN products p 
ON s.product_id = p.product_id
UNION ALL
SELECT s.product_id AS stock_pid, s.stock_quantity, p.product_id , p.cost
FROM stock s
RIGHT JOIN products p 
ON s.product_id = p.product_id;