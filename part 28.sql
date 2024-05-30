use tips;
create table prod(ID int, name varchar(20));
insert into prod values 
(1, 'A'),(2, 'B'),(3,'C'),(4,'D'),(5,'E');
create table colors(color_ID int, color varchar(20));
insert into colors values 
(1, 'Blue'),(2, 'Green'),(3,'Orange');
create table sizes(size_ID int, size varchar(20));
insert into sizes values 
(1, 'M'),(2, 'L'),(3,'XL');
create table transactn(order_ID int, prod_name varchar(20), color varchar(20), size varchar(10), amount int);
insert into transactn values 
(1,'A','Blue', 'L', 300),
(2,'B','Blue', 'XL', 150),
(3,'B','Green','L',250),
(4,'C','Blue', 'L', 250),
(5,'E','Green', 'L', 270),
(6,'D','Orange','L',300),
(7,'D','Green','M',250);

SELECT p.*, c.*
FROM prod p, colors c;

-- cross join use case - master data
/* the company has 5 products as in prod table in which each product has all colors and sizes from colors and size tables each.cross
 so it will be 5 *3*3 this is called SKU .
 the store manager wants sales for each products color , size combination. there are other combination also in color and size table.cross
 so the manager wants all those combination as a master data, and show null or 0 for those having no sale */

WITH master_data AS (
    SELECT p.name, c.color, s.size 
    FROM prod p, colors c, sizes s
),
sales AS(
    SELECT prod_name, color, size, SUM(amount) AS totalamount
    FROM transactn t
    GROUP BY prod_name, color, size
)
SELECT md.name, md.color, md.size,
    IFNULL(s.totalamount, 0) AS totalamount
FROM master_data md
LEFT JOIN sales s 
ON md.name = s.prod_name AND md.color = s.color AND md.size = s.size
ORDER BY totalamount;


-- use case 2 - prepare large no of rows for performance testing
SELECT ROW_NUMBER() OVER(ORDER BY t.order_ID) as order_id, 
		t.prod_name, t.color, t.size, t.amount 
FROM transactn t , stock s;

