use tips;

CREATE TABLE t1 (
 id1 INT
);
INSERT INTO t1
VALUES
 (1), (1);
 
 CREATE TABLE t2 (
 id2 INT
);
INSERT INTO t2
VALUES
 (1), (1), (1);
 
Select * FROM t1
INNER JOIN t2 ON t1.id1 = t2.id2;

Select * FROM t1
LEFT JOIN t2 ON t1.id1 = t2.id2
union all
Select * FROM t1
RIGHT JOIN t2 ON t1.id1 = t2.id2;

Select * FROM t1
FULL OUTER JOIN t2 ON t1.id1 = t2.id2;

INSERT INTO t1 VALUE (2);
INSERT INTO t2 VALUE (3);
SELECT * FROM t1;
SELECT * FROM t2;