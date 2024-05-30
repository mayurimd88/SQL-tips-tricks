use tips;

create table emp_compensation(
	emp_id int, 
	salary_component_type varchar(50),
	val int);
    
insert into emp_compensation
 value(1, "salary", 10000),
 (1, "bonus",5000),
 (1, "hike_percent", 10),
 (2, "salary", 15000),
 (2, "bonus", 7000),
 (2, "hike_percent", 6),
 (3, "salary", 12000),
 (3, "bonus", 6000),
 (3, "hike_percent", 7); 
select * from emp_compensation;

-- convert row to columns
CREATE TABLE emp_compensation_pivot AS
SELECT emp_id,
    SUM(CASE WHEN salary_component_type = 'salary' THEN val ELSE 0 END) AS salary,
    SUM(CASE WHEN salary_component_type = 'bonus' THEN val ELSE 0 END) AS bonus,
    SUM(CASE WHEN salary_component_type = 'hike_percent' THEN val ELSE 0 END) AS hike_percent
FROM emp_compensation
GROUP BY emp_id;
SELECT * FROM emp_compensation_pivot;

-- convert columns to rows
SELECT emp_id, 'salary' AS salary_component_type, salary AS val FROM emp_compensation_pivot
UNION ALL
SELECT emp_id, 'bonus' AS salary_component_type, bonus AS val FROM emp_compensation_pivot
UNION ALL
SELECT emp_id, 'hike_percent' AS salary_component_type, hike_percent AS val FROM emp_compensation_pivot
ORDER BY emp_id, salary_component_type;

DROP TABLE emp_compensation_pivot;

