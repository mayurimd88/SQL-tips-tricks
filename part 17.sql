use tips;

SELECT Customer_ID, Customer_Name
FROM superstore
LIMIT 20;

-- exact match "Andrew Allen"
SELECT Customer_ID, Customer_Name
FROM superstore
WHERE Customer_Name LIKE "Andrew Allen"
LIMIT 20;

-- customer name starting with "Andrew"
SELECT Customer_ID, Customer_Name
FROM superstore
WHERE Customer_Name LIKE "Andrew%"
LIMIT 20;

-- customer ending with "Hoffman"
SELECT Customer_ID, Customer_Name
FROM superstore
WHERE Customer_Name LIKE "%hoffman"
LIMIT 20;

-- name starting with H & ending with N
SELECT Customer_ID, Customer_Name
FROM superstore
WHERE Customer_Name LIKE "h%n"
LIMIT 20;

-- name whose second character is a
SELECT Customer_ID, Customer_Name
FROM superstore
WHERE Customer_Name LIKE "_a%"
LIMIT 20;

-- names other than name starting with A
SELECT Customer_ID, Customer_Name
FROM superstore
WHERE Customer_Name NOT LIKE "A%"
LIMIT 20;