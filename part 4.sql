use tips;

SELECT * FROM emp;

SET SQL_SAFE_UPDATES=0;

UPDATE `tips`.`emp`
SET
manager_id = null
WHERE emp_id= 8;

SELECT 
    COUNT(*) AS aall,
    COUNT(1) AS one1,
    COUNT(0) AS zero,
    COUNT(- 1) AS minusone,
    COUNT(manager_id) AS managerId,
    COUNT(DISTINCT manager_id) AS DistinctmanagerId
FROM
    emp;