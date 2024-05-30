use tips;

-- simple sum
SELECT SUM(amount) FROM transactions;

-- sum using group by
SELECT cust_id, SUM(amount)
FROM transactions
GROUP BY cust_id;

-- using window function
SELECT *, 
SUM(amount) OVER(PARTITION BY cust_id) AS c_amount,
SUM(amount) OVER(ORDER BY order_date) AS running_amount,
SUM(amount) OVER(PARTITION BY cust_id ORDER BY order_date) AS amount
FROM transactions;

-- different variations to calculate rolling
SELECT *, 
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS rolling_2,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) AS rolling_4,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling,
SUM(amount) OVER(PARTITION BY cust_id ORDER BY order_date 
			ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS c_rolling
FROM transactions;

-- analytics function without using them
SELECT *, 
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS lag_amount,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS lead_amount
FROM transactions;