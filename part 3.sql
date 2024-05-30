use tips;

SELECT 
    e.emp_id,
    e.emp_name,
    m.emp_name AS manager_name,
    e.salary,
    m.salary AS manager_salary
FROM
    emp e
        INNER JOIN
    emp m ON e.manager_id = m.emp_id
WHERE
    e.salary > m.salary;