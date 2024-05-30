use tips;

select manager_id from emp;

with cte_duplicate as
(select manager_id from emp group by manager_id having count(1)>1),
cte_rank as 
(select manager_id, rank() over (order by manager_id ) as rankid from cte_duplicate)
select e.manager_id, "DUPLICATE" + cast(cr.rankid as varchar(5)) as result
from emp e
left join cte_rank cr on e.manager_id = cr.manager_id
;

WITH cte_duplicate AS (
    SELECT manager_id FROM emp
    GROUP BY manager_id HAVING COUNT(1) > 1
),
cte_rank AS (
    SELECT manager_id, RANK() OVER (ORDER BY manager_id) AS rankid
    FROM cte_duplicate
)
SELECT e.manager_id, 
       CASE WHEN cr.rankid IS NOT NULL 
            THEN CONCAT('DUPLICATE-', cr.rankid) 
            ELSE 'NULL' 
       END AS result
FROM emp e
LEFT JOIN cte_rank cr ON e.manager_id = cr.manager_id;

