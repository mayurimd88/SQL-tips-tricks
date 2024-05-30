use tips;
create table employee( emp_id int, emp_name varchar(20), department_id int, salary int, manager_id int, emp_age int); 
insert into employee values (1, 'Ankit', 100, 10000, 4, 39); insert into employee values (2, 'Mohit', 100, 15000, 5, 48); 
insert into employee values (3, 'Vikas', 100, 10000,4,37); insert into employee values (4, 'Rohit', 100, 5000, 2, 16); 
insert into employee values (5, 'Mudit', 200, 12000, 6,55); insert into employee values (6, 'Agam', 200, 12000,2, 14); 
insert into employee values (7, 'Sanjay', 200, 9000, 2,13); insert into employee values (8, 'Ashish', 200,5000,2,12); 
insert into employee values (9, 'Mukesh',300,6000,6,51); insert into employee values (10, 'Rakesh',300,7000,6,50);

-- print employee details whose salary is more than their department average salary
-- independent subquery
SELECT e.*, d.avg_dep_salary
FROM employee e
INNER JOIN
(SELECT department_id, ROUND(AVG(salary)) AS avg_dep_salary
FROM employee
GROUP BY department_id) d ON e.department_id = d.department_id
WHERE e.salary > d.avg_dep_salary;

-- subquery can run independently
-- it runs only onces

-- correlated subquery
SELECT *
FROM employee e1
WHERE salary > (SELECT AVG(e2.salary) FROM employee e2 WHERE e1.department_id = e2.department_id);

-- cannot run independently
-- runs as much times as records present




















