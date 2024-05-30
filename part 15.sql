use tips;

SELECT CAST('2000-01-01' as date) as cal_date,
(YEAR ('2000-01-01')) as cal_year,
(DAYOFYEAR ('2000-01-01')) as cal_year_day,
(QUARTER ('2000-01-01')) as cal_quarter,
(MONTH ('2000-01-01')) as cal_month,
(MONTHNAME ('2000-01-01')) as cal_month_name,
(DAY ('2000-01-01')) as cal_month_day,
(WEEK ('2000-01-01')) as cal_week,
(DAYOFWEEK ('2000-01-01')) as cal_weekday,
(DAYNAME ('2000-01-01')) as cal_dayname;

WITH RECURSIVE cte AS(
 SELECT 1 AS id
 UNION ALL
 SELECT id + 1 AS id
 FROM cte
 WHERE id < 10
 )
SELECT * FROM cte;

-- recursive cte. 
WITH RECURSIVE cte AS(
SELECT CAST('2000-01-01' as date) as cal_date,
(YEAR ('2000-01-01')) as cal_year,
(DAYOFYEAR ('2000-01-01')) as cal_year_day,
(QUARTER ('2000-01-01')) as cal_quarter,
(MONTH ('2000-01-01')) as cal_month,
(MONTHNAME ('2000-01-01')) as cal_month_name,
(DAY ('2000-01-01')) as cal_month_day,
(WEEK ('2000-01-01')) as cal_week,
(DAYOFWEEK ('2000-01-01')) as cal_weekday,
(DAYNAME ('2000-01-01')) as cal_dayname
UNION ALL
SELECT DATE_ADD(cal_date, INTERVAL 1 DAY) AS cal_date,
(YEAR (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_year,
(DAYOFYEAR (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_year_day,
(QUARTER (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_quarter,
(MONTH (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_month,
(MONTHNAME (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_month_name,
(DAY (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_month_day,
(WEEK (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_week,
(DAYOFWEEK (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_weekday,
(DAYNAME (DATE_ADD(cal_date, INTERVAL 1 DAY))) as cal_dayname
FROM cte
WHERE cal_date <= cast(	'2050-12-30' AS date)
)
SELECT  /*+ SET_VAR(cte_max_recursion_depth = 20000) */ 
ROW_NUMBER() OVER(ORDER BY cal_date ASC) AS id, 
cal_date, cal_year, cal_year_day, cal_quarter, cal_month, cal_month_name, cal_month_day, cal_week, cal_weekday, cal_dayname
FROM cte ;






