
WITH RECURSIVE calender_dim AS (
    SELECT CAST('2000-01-01' AS DATE) AS cal_date,
           YEAR('2000-01-01') AS cal_year,
           DAYOFYEAR('2000-01-01') AS cal_year_day,
           QUARTER('2000-01-01') AS cal_quarter,
           MONTH('2000-01-01') AS cal_month,
           MONTHNAME('2000-01-01') AS cal_month_name,
           DAY('2000-01-01') AS cal_month_day,
           WEEK('2000-01-01') AS cal_week,
           DAYOFWEEK('2000-01-01') AS cal_weekday,
           DAYNAME('2000-01-01') AS cal_dayname
    UNION ALL
    SELECT /*+ SET_VAR(cte_max_recursion_depth = 20000) */
    DATE_ADD(cal_date, INTERVAL 1 DAY) AS cal_date,
           YEAR(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_year,
           DAYOFYEAR(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_year_day,
           QUARTER(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_quarter,
           MONTH(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_month,
           MONTHNAME(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_month_name,
           DAY(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_month_day,
           WEEK(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_week,
           DAYOFWEEK(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_weekday,
           DAYNAME(DATE_ADD(cal_date, INTERVAL 1 DAY)) AS cal_dayname
    FROM calender_dim
    WHERE cal_date <= CAST('2050-12-30' AS DATE)
),
 todays_data AS (
    SELECT * FROM calender_dim WHERE cal_date = CURDATE()
),
cal AS (
    SELECT 
    c.*, 
           t.cal_year AS current_year,
           t.cal_date AS todays_date,
           t.cal_year_day AS current_cal_year_day,
           t.cal_quarter AS current_quarter,
           t.cal_month AS current_month, 
           t.cal_month_day AS current_cal_month_day
    FROM calender_dim c
    CROSS JOIN todays_data t
    WHERE c.cal_year BETWEEN t.cal_year - 2 AND t.cal_year
),
cte AS (
    SELECT 'FY' AS timeframe,
           'FY' AS timeframe_id,
           MIN(CASE WHEN cal_year = current_year THEN cal_date END) AS start_date_ty,
           MAX(CASE WHEN cal_year = current_year THEN cal_date END) AS end_date_ty,
           MIN(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS start_date_ly,
           MAX(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS end_date_ly,
           MIN(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS start_date_lly,
           MAX(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS end_date_lly
    FROM cal
    UNION ALL
    SELECT 'QUARTER' AS timeframe,
           CAST(cal_quarter AS CHAR(3)) AS timeframe_id,
           MIN(CASE WHEN cal_year = current_year THEN cal_date END) AS start_date_ty,
           MAX(CASE WHEN cal_year = current_year THEN cal_date END) AS end_date_ty,
           MIN(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS start_date_ly,
           MAX(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS end_date_ly,
           MIN(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS start_date_lly,
           MAX(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS end_date_lly
    FROM cal
    GROUP BY cal_quarter
    UNION ALL
    SELECT 'YTD' AS timeframe,
           'YTD' AS timeframe_id,
           MIN(CASE WHEN cal_year = current_year THEN cal_date END) AS start_date_ty,
           MAX(CASE WHEN cal_year = current_year THEN cal_date END) AS end_date_ty,
           MIN(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS start_date_ly,
           MAX(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS end_date_ly,
           MIN(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS start_date_lly,
           MAX(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS end_date_lly
    FROM cal
    WHERE cal_year_day <= current_cal_year_day
    UNION ALL
    SELECT 'QTD' AS timeframe,
           'QTD' AS timeframe_id,
           MIN(CASE WHEN cal_year = current_year THEN cal_date END) AS start_date_ty,
           MAX(CASE WHEN cal_year = current_year THEN cal_date END) AS end_date_ty,
           MIN(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS start_date_ly,
           MAX(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS end_date_ly,
           MIN(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS start_date_lly,
           MAX(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS end_date_lly
    FROM cal
    WHERE cal_quarter = current_quarter AND cal_year_day <= current_cal_year_day
    UNION ALL
    SELECT 'MTD' AS timeframe,
           'MTD' AS timeframe_id,
           MIN(CASE WHEN cal_year = current_year THEN cal_date END) AS start_date_ty,
           MAX(CASE WHEN cal_year = current_year THEN cal_date END) AS end_date_ty,
           MIN(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS start_date_ly,
           MAX(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS end_date_ly,
           MIN(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS start_date_lly,
           MAX(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS end_date_lly
    FROM cal
    WHERE cal_month = current_month AND cal_month_day <= current_cal_month_day
    UNION ALL
    SELECT 'month' AS timeframe,
           CAST(cal_month AS CHAR(2)) AS timeframe_id,
           MIN(CASE WHEN cal_year = current_year THEN cal_date END) AS start_date_ty,
           MAX(CASE WHEN cal_year = current_year THEN cal_date END) AS end_date_ty,
           MIN(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS start_date_ly,
           MAX(CASE WHEN cal_year = current_year - 1 THEN cal_date END) AS end_date_ly,
           MIN(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS start_date_lly,
           MAX(CASE WHEN cal_year = current_year - 2 THEN cal_date END) AS end_date_lly
    FROM cal
    GROUP BY cal_month
)
SELECT * FROM cte;

select t.ï»¿timeframe, t.timeframe_id
, round(sum(case when o.order_date between t.start_date_ty and t.end_date_ty then sales end)) as ty_sales 
, round(sum(case when o.order_date between t.start_date_ly and t.end_date_ly then sales end)) as ly_sales
, round(sum(case when o.order_date between t.start_date_lly and t.end_date_lly then sales end)) as lly_sales
from 
order_details o 
inner join cte t on o.order_date between t.start_date_ty and t.end_date_ty
or o.order_date between t.start_date_ly and t.end_date_ly
or o.order_date between t.start_date_lly and t.end_date_lly
group by t.ï»¿timeframe, t.timeframe_id;

