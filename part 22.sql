use tips;

-- normal group by
SELECT continent, SUM(amount) AS total
FROM orders
GROUP BY continent;

-- continent wise sales
SELECT continent, NULL country, NULL city, SUM(amount) AS total
FROM orders
GROUP BY continent;

/* combination of continent-country-city wise sales 
	and continent wise sales and continent-country wise sales
    and overall sales */
-- Method 1
SELECT continent, country, city, SUM(amount) AS total
FROM orders
GROUP BY continent,country,city
UNION ALL
SELECT continent, NULL country, NULL city, SUM(amount) AS total
FROM orders
GROUP BY continent
UNION ALL
SELECT continent, country, NULL city, SUM(amount) AS total
FROM orders
GROUP BY continent, country
UNION ALL
SELECT NULL continent,NULL country, NULL city, SUM(amount) AS total
FROM orders;

-- Method 2
SELECT continent, country, city, SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(continent,country,city);

-- cube -it gives all the possible combinations
SELECT continent, country, city, SUM(amount) AS total
FROM orders
GROUP BY CUBE(continent,country,city);

-- grouping sets- make group as per need
SELECT continent, country, city, SUM(amount) AS total
FROM orders
GROUP BY GROUPING SETS ((continent,country),(city));

SELECT continent, country, city, SUM(amount) AS total
FROM orders
GROUP BY GROUPING SETS ((continent,country),(city),(continent,city));


