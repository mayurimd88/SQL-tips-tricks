use tips;

with frequent_cte as (
select salary, count(salary) as frequency from emp group by salary)
select * from frequent_cte 
where frequency = (select max(frequency) from frequent_cte);

with frequent_cte as (
select salary, count(salary) as frequency from emp group by salary),
rank_cte as (
select *, rank() over (order by frequency desc) as fq
from frequent_cte)
select * from rank_cte where fq = 1;
