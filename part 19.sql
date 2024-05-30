use tips;

SELECT * FROM emp e
LEFT JOIN dept d ON e.department_id = d.dept_id;

-- using filter AND 
SELECT * FROM emp e
LEFT JOIN dept d ON e.department_id = d.dept_id AND d.dept_name = "IT";

-- using filter WHERE 
SELECT * FROM emp e
LEFT JOIN dept d ON e.department_id = d.dept_id WHERE d.dept_name = "IT";

-- display null dept_name
SELECT * FROM emp e
LEFT JOIN dept d ON e.department_id = d.dept_id WHERE d.dept_name is null;

SELECT * FROM emp e
LEFT JOIN dept d ON e.department_id = d.dept_id WHERE e.salary = 14400;