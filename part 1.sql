create database tips;
create table emp(
	emp_id int, 
	emp_name varchar(50),
	department_id varchar(50),
	salary int,
	manager_id int);
 insert into emp
 values(1, "Ankit", 100, 10000, 4),
 (2, "mohit", 100, 15000, 5),
 (3, "vikas", 100, 10000, 4),
 (4, "rohit", 100, 5000, 2),
 (5, "mohit", 200, 12000, 6),
 (6, "agam", 200, 12000, 2),
 (7, "sanjay", 200, 9000, 2),
 (8, "ashish", 200, 5000,2);
 
select * from emp
where salary > 10000;

select department_id, avg(salary)
from emp
group by department_id
having avg(salary) > 9500;

select department_id, avg(salary) from emp
where salary > 10000
group by department_id
having avg(salary) > 12000;








