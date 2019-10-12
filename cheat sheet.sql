--CTRL + SHIFT + R = prestane se podtrhavat cervene

SELECT email		--SELECT = vyber sloupce
FROM customer		--FROM = z jake tabulky
WHERE active = 0	--WHERE = radky

--ORDER BY
ORDER BY title DESC --ASC/DESC serazeni vysledku

--datum string
WHERE payment_date >= '2006-01-01' AND amount < 2   --datum se da napsat i takhle

--mnozina
WHERE rating = 'G' OR rating = 'PG' OR rating = 'PG-13'
WHERE rating IN ('G', 'PG', 'PG-13')

--LIKE '%bla'
WHERE (title LIKE '%RAINBOW%' OR title LIKE 'TEXAS%') AND length > 70	--LIKE porovnava atrubuty s %, '%bla' libovolny pocet znaku pred 'bla'

--BETWEEN
WHERE length >= 80 AND length <= 90
WHERE length BETWEEN 80 AND 90

--DISTINCT duplicity
SELECT DISTINCT special_features	--DISTINCT nebudou vypsane duplicitni

--XOR
SELECT *
FROM film
WHERE
	rental_duration < 4 AND rating != 'PG' OR
	rental_duration >= 4 AND rating = 'PG'

--NULL
WHERE postal_code IS NOT NULL

--YEAR(), MONTH(), DAY()
SELECT payment_id, YEAR(payment_date) AS rok, MONTH(payment_date) AS mesic, DAY(payment_date) AS den

--LEN() vrati delku stringu
WHERE LEN(title) != 20

--DATEDIFF() rozdil casu
SELECT DATEDIFF(MINUTE, rental_date, return_date) AS minuty

--spojeni stringu
SELECT (first_name + ' ' + last_name) AS full_name

--COALESCE() vysledek je rovny prvnimu parametru, ktery neni NULL
SELECT COALESCE(postal_code, '(prazdne)') AS PSC

--CAST() pretypovani
SELECT (CAST(rental_date AS VARCHAR) + ' - ' + CAST(return_date AS VARCHAR)) AS interval

--CAST() + COALESCE()
SELECT rental_id, (CAST(rental_date AS VARCHAR) + ' - ' + COALESCE(CAST(return_date AS VARCHAR), '')) AS interval

--COUNT()
SELECT COUNT(*) AS pocet_filmu
SELECT COUNT(DISTINCT(rating)) AS pocet_kategorii

--MIN(), MAX(), AVG()
SELECT
	MIN(length) AS min_length,
	MAX(length) AS max_length,
	AVG(CAST(length AS FLOAT)) AS avg_length,
	(SUM(length) / COUNT(length)) AS test

