use tips;

create table products
(product_id int,
cost int);
insert into products
value(1,200),
(2, 300),
(3,400),
(4,500),
(5,600);
select * from products;

select *, sum(cost) over (order by cost asc) as running_cost
from products;

-- if any duplicate cost with unique id --
/* select *, 
sum(cost) over (order by cost asc rows between unbounded preceding and current row) as running_cost
from products; */
