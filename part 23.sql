use tips;

-- merge statements - update,insert, delete
MERGE targetproduct AS tp
USING sourceproduct AS sp
ON tp.prodID = sp.prodID
WHEN matched THEN UPDATE
SET tp.price = sp.price
WHEN NOT MATCHED BY TARGET THEN 
INSERT VALUES(sp.prodID, sp.prodname, sp.price)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

set sql_safe_updates=0;
-- UPDATE existing records
UPDATE targetproduct AS tp
INNER JOIN sourceproduct AS sp ON tp.prodID = sp.prodID
SET tp.price = sp.price;

-- INSERT new records
INSERT INTO targetproduct (prodID, prodname, price)
SELECT sp.prodID, sp.prodname, sp.price
FROM sourceproduct AS sp
LEFT JOIN targetproduct AS tp ON sp.prodID = tp.prodID
WHERE tp.prodID IS NULL;

-- DELETE records not present in the source
DELETE tp FROM targetproduct AS tp
LEFT JOIN sourceproduct AS sp ON tp.prodID = sp.prodID
WHERE sp.prodID IS NULL;
