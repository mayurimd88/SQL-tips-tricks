use tips;
-- order of execution
-- from > join > where > group by > having > select > order by > top > 


select   e.emp_id, e.department_id, d.dept_name, (e.salary) as dept_salary 
from emp e
inner join dept d on e.department_id= d.dept_id
where e.salary > 6000
group by e.emp_id, e.department_id, d.dept_name, dept_salary
having sum(e.salary) >1000
order by dept_salary desc

