use tips;

CREATE TABLE emp1 (
 emp_id INT,
 designation varchar(50)
);
CREATE TABLE emp2 (
 emp_id INT,
 designation varchar(50)
);
INSERT INTO emp1
VALUES
 (1, "Trainee"),
 (2, "Developer"),
 (3, "Senior Developer"),
 (4, "Manager");
 INSERT INTO emp2
VALUES
 (1, "Developer"),
 (2, "Developer"),
 (3, "Manager"),
 (5, "Trainee");
 -- find change in employee status
 
 select isnull(emp1.emp_id, emp2.emp_id) as emp_id ,
 case when emp1.designation != emp2.designation then "promoted"
 when emp2.designation is null then "resigned"
 else "new" end as comment
 from emp1 
 full outer join emp2 on emp1.emp_id = emp2.emp_id
 where isnull(emp1.designation,"xxx") != isnull(emp2.designation,"yyy");
 
 Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'outer join emp2 on emp1.emp_id = emp2.emp_id  where isnull(emp1.designation,"xxx' at line 6

SELECT 
    IFNULL(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE 
        WHEN emp1.designation != emp2.designation THEN "promoted"
        WHEN emp2.designation IS NULL THEN "resigned"
        ELSE "new" 
    END AS comment
FROM 
    emp1 
RIGHT JOIN 
    emp2 ON emp1.emp_id = emp2.emp_id
WHERE 
    IFNULL(emp1.designation,'xxx') != IFNULL(emp2.designation,'yyy');

-- Query using RIGHT JOIN, LEFT JOIN, and UNION ALL instead of FULL OUTER JOIN

-- Query for employees present in emp1 but not in emp2 (LEFT JOIN)
SELECT 
    IFNULL(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE 
        WHEN emp2.emp_id IS NULL THEN 'new'
        ELSE 'promoted'
    END AS comment
FROM 
    emp1 
LEFT JOIN 
    emp2 ON emp1.emp_id = emp2.emp_id
WHERE 
    IFNULL(emp2.designation, 'yyy') != IFNULL(emp1.designation, 'xxx')

UNION ALL

-- Query for employees present in emp2 but not in emp1 (RIGHT JOIN)
SELECT 
    IFNULL(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE 
        WHEN emp1.emp_id IS NULL THEN 'resigned'
        ELSE 'promoted'
    END AS comment
FROM 
    emp1 
RIGHT JOIN 
    emp2 ON emp1.emp_id = emp2.emp_id
WHERE 
    IFNULL(emp1.designation, 'xxx') != IFNULL(emp2.designation, 'yyy');

-- Query to get the desired result
SELECT 
    COALESCE(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE 
        WHEN emp1.designation IS NULL AND emp2.designation IS NOT NULL THEN 'new'
        WHEN emp1.designation IS NOT NULL AND emp2.designation IS NULL THEN 'resigned'
        WHEN emp1.designation != emp2.designation THEN 'promoted'
    END AS comment
FROM 
    emp1 
LEFT JOIN 
    emp2 ON emp1.emp_id = emp2.emp_id

UNION ALL

SELECT 
    COALESCE(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE 
        WHEN emp1.designation IS NULL AND emp2.designation IS NOT NULL THEN 'new'
        WHEN emp1.designation IS NOT NULL AND emp2.designation IS NULL THEN 'resigned'
        WHEN emp1.designation != emp2.designation THEN 'promoted'
    END AS comment
FROM 
    emp1 
RIGHT JOIN 
    emp2 ON emp1.emp_id = emp2.emp_id
WHERE 
    emp1.emp_id IS NULL;

 
 -- Query to get the desired result
 
SELECT IFNULL(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE WHEN emp1.designation IS NULL AND emp2.designation IS NOT NULL THEN 'new'
        WHEN emp1.designation IS NOT NULL AND emp2.designation IS NULL THEN 'resigned'
        WHEN emp1.designation != emp2.designation THEN 'promoted'
        ELSE 'not promoted'
    END AS comment
FROM emp1 
LEFT JOIN emp2 ON emp1.emp_id = emp2.emp_id
UNION ALL
SELECT IFNULL(emp1.emp_id, emp2.emp_id) AS emp_id,
    CASE WHEN emp1.designation IS NULL AND emp2.designation IS NOT NULL THEN 'new'
        WHEN emp1.designation IS NOT NULL AND emp2.designation IS NULL THEN 'resigned'
        WHEN emp1.designation != emp2.designation THEN 'promoted'
        ELSE 'not promoted'
    END AS comment
FROM emp1 
RIGHT JOIN emp2 ON emp1.emp_id = emp2.emp_id
WHERE emp1.emp_id IS NULL;

 
 
 
 
 
 
 
 
 
 