use tips;

CREATE TABLE sales
(Order_ID int, Order_Date date, Sales int);
INSERT INTO sales VALUES
(152156, '2016-01-05', 261 ),
(138688, '2016-02-12', 14),
(108966, '2016-03-11', 731),
(115812, '2016-04-09', 907),
(115812, '2016-05-09', 7),
(115812, '2016-06-09', 114),
(114212, '2016-07-15', 22),
(161389, '2016-08-05', 911),
(118983, '2016-09-22', 15),
(118983, '2016-10-22',1706);


-- postgresql
WITH year_month_sales AS (
SELECT datepart(year, 'Order_Date')as year_order, datepart(month,`Order_Date`)as month_order, sum(Sales) as totalsales 
FROM sales
GROUP BY datepart(year, 'Order_Date'), datepart(month,`Order_Date`)  
)
SELECT *, 
SUM(sales) OVER(ORDER BY year_order asc, month_order asc rows between 2 preceding and 0 preceding) as rolling_3sum
FROM year_month_sales;


-- mysql
WITH year_month_sales AS (
    SELECT EXTRACT(YEAR FROM Order_Date) as order_year, 
           EXTRACT(MONTH FROM Order_Date) as order_month, 
           SUM(Sales) as totalsales 
    FROM sales
    GROUP BY EXTRACT(YEAR FROM Order_Date), EXTRACT(MONTH FROM Order_Date)
)
SELECT order_year, order_month, totalsales,
       SUM(totalsales) OVER(ORDER BY order_year ASC, 
       order_month asc ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING) as rolling_3mnth
FROM year_month_sales;

WITH year_month_sales AS (
    SELECT EXTRACT(YEAR FROM Order_Date) as order_year, 
           EXTRACT(MONTH FROM Order_Date) as order_month, 
           SUM(Sales) as totalsales 
    FROM sales
    GROUP BY EXTRACT(YEAR FROM Order_Date), EXTRACT(MONTH FROM Order_Date)
)
SELECT order_year, order_month, totalsales,
       SUM(totalsales) OVER(ORDER BY order_year ASC, order_month asc ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) as rolling_sum,
       AVG(totalsales) OVER(ORDER BY order_year ASC, order_month asc ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) as rolling_avg,
       MIN(totalsales) OVER(ORDER BY order_year ASC, order_month asc ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) as rolling_min,
       MAX(totalsales) OVER(ORDER BY order_year ASC, order_month asc ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) as rolling_max
FROM year_month_sales;



