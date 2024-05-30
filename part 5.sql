use tips;

SELECT 
    emp_name, REPLACE(emp_name, ' ', '') AS replace_name
FROM
    emp;
    
SELECT 
	emp_name, REPLACE(emp_name, 'hi', '') AS replace_name,
    round((length(emp_name)- length( REPLACE(emp_name, 'hi', '')))/length('hi')) AS replace_len
FROM
    emp;
    
SELECT  COUNT(emp_name) AS word_count
FROM emp
WHERE INSTR(emp_name, 'mohit') > 0;
    
    
    
    
    
