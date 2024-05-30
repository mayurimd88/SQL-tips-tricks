use tips;
insert into emp values (9, "vikas", 300, 15000, 3);
CREATE TABLE dept (
 dept_id INT,
 dept_name VARCHAR(20)
);
INSERT INTO dept 
	VALUES
		(100, "IT"),
		(200, "Marketing");
 
 CREATE TABLE emp (
 emp_id INT,
 emp_name VARCHAR(20),
 department_id INT,
 salary INT,
 manager_id INT
);
INSERT INTO emp 
VALUES
 (1, "Ankit", 100, 10000, 4),
 (2, "mohit", 100, 15000, 5),
 (3, "vikas", 100, 10000, 4),
 (4, "rojit", 100, 5000, 2),
 (5, "mohit", 200, 10000, 6),
 (6, "agam", 200, 12000, 2),
 (7, "anam", 200, 12000, 3),
 (8, "ashish", 200, 5000, 5),
 (9, "vikas", 300, 15000,4);
 
 select * from dept;
 select * from emp;
 
SET SQL_SAFE_UPDATES = 0;

 -- update with where clause
UPDATE emp SET salary = 20000 WHERE emp_id = 3;
SELECT * FROM emp;
  
  -- update multiple values
UPDATE emp SET salary = 25000, department_id =200  WHERE emp_id = 4;
SELECT * FROM emp;
 
 -- update col with case when
 UPDATE emp 
SET 
    salary = CASE
        WHEN department_id = 100 THEN salary * 1.1
        WHEN department_id = 200 THEN salary * 1.2
        ELSE salary
    END;
SELECT * FROM emp;
 
UPDATE emp SET emp_name = "rohit" WHERE emp_id = 4;

 -- update using joins
ALTER TABLE emp ADD dept_name VARCHAR(20);
UPDATE emp 
SET dept_name = d.dept_name
FROM emp e
INNER JOIN dept d ON e.department_id = d.dept_id; 
SELECT * FROM emp; 

ALTER TABLE emp ADD dept_name VARCHAR(20);
-- SET SQL_SAFE_UPDATES = 0;
UPDATE emp e
INNER JOIN dept d ON e.department_id = d.dept_id
SET e.dept_name = d.dept_name;
SELECT * FROM emp;







-- interview questions swap genders
-- add col gender and insert values
ALTER TABLE emp ADD gender VARCHAR(20);
UPDATE emp
SET gender = CASE WHEN department_id = 100 THEN "male" ELSE "female" END;
-- swap genders
UPDATE emp 
SET gender = CASE WHEN gender = "male" THEN "female" ELSE "male" END;
SELECT * FROM emp;
 
 
 
 