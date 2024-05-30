use tips;

-- first values
SELECT *, 
FIRST_VALUE(emp_name) OVER(PARTITION BY department_id ORDER BY age) AS youngest_emp
FROM emp;

-- last values
SELECT *,
LAST_VALUE(emp_name) OVER(PARTITION BY department_id ORDER BY age)AS oldest_emp
FROM emp;

SELECT *,
LAST_VALUE(emp_name) OVER(PARTITION BY department_id ORDER BY age 
					ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)AS oldest_emp
FROM emp
ORDER BY department_id ,age;

SELECT *, 
FIRST_VALUE(emp_name) OVER(PARTITION BY department_id ORDER BY age DESC) AS oldest_emp
FROM emp
ORDER BY department_id, age;


-- for practice from comment
-- what will be the output if age n dept is same
create table age1 (name varchar(50),
dept_id int, dept_name varchar(50), age int);
insert into age1 values
("ashish", 100,"marketing",20),
("ashish", 100,"marketing",20),
("ashish", 100,"marketing",20);

SELECT *, 
FIRST_VALUE(name) OVER(PARTITION BY dept_id ORDER BY age) AS youngest_emp
FROM age1;