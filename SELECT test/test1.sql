
SELECT DISTINCT c.cID, c.name, (
	SELECT COUNT(DISTINCT pu.pID)
	FROM test.Purchase pu
	WHERE pu.cID = c.cID
) AS pocet
FROM test.Customer c
WHERE NOT EXISTS (
	SELECT *
	FROM test.Purchase pu
		JOIN test.Employee e ON pu.eID = e.eID
	WHERE c.cID = pu.cID AND e.country = 'America'
)

SELECT DISTINCT c.cID, c.name
FROM test.Customer c
WHERE c.cID IN (
	SELECT pu.cID
	FROM test.Purchase pu
		JOIN test.Product p ON pu.pID = p.pID
	WHERE c.cID = pu.cID AND
		YEAR(pu.purchaseDay) = 2014 AND p.trademark = 'Green line' 
) AND c.cID IN (
	SELECT pu.cID
	FROM test.Purchase pu
		JOIN test.Product p ON pu.pID = p.pID
	WHERE c.cID = pu.cID AND
		YEAR(pu.purchaseDay) = 2013 AND p.trademark = 'Electrolux' 
)
