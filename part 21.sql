use tips;

SELECT *
FROM emp3;

SELECT 
CONCAT('INSERT INTO emp VALUES(',emp_id,',',CHAR(39),emp_name,CHAR(39),',',salary,',',CHAR(39),dob,CHAR(39),');') 
AS dynamic_insert
FROM emp3;


INSERT INTO emp3 VALUES(1,'Ankit',11000,'2000-09-01');
INSERT INTO emp3 VALUES(2,'mohit',16500,'1997-05-07');
INSERT INTO emp3 VALUES(3,'vikas',22000,'1994-08-05');
INSERT INTO emp3 VALUES(4,'rohit',30000,'1994-08-05');
INSERT INTO emp3 VALUES(5,'mohit',12000,'2000-09-01');
SELECT * FROM emp3;
