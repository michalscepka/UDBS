--CTRL + SHIFT + R = prestane se podtrhavat cervene

--1
SELECT email		--SELECT = vyber sloupce
FROM customer		--FROM = z jake tabulky
WHERE active = 0	--WHERE = radky

--2
SELECT title, description
FROM film
WHERE rating = 'G'
ORDER BY title DESC

--3
SELECT *
FROM payment
WHERE payment_date >= '2006-01-01' AND amount < 2

--4
SELECT description
FROM film
WHERE rating = 'G' OR rating = 'PG'

--5
SELECT description
FROM film
--WHERE rating = 'G' OR rating = 'PG' OR rating = 'PG-13'
WHERE rating IN ('G', 'PG', 'PG-13')

--6
SELECT description
FROM film
WHERE rating NOT IN ('G', 'PG', 'PG-13')

--7
SELECT *
FROM film
WHERE length > 50 AND rental_duration IN (3, 5)
--WHERE length > 50 AND (rental_duration = 3 OR rental_duration = 5)

--8
SELECT *
FROM film
WHERE (title LIKE '%RAINBOW%' OR title LIKE 'TEXAS%') AND length > 70	--'%bla' libovolny pocet znaku pred 'bla'

--9
SELECT *
FROM film
WHERE
	description LIKE '%And%' AND
	--length >= 80 AND length <= 90 AND
	length BETWEEN 80 AND 90 AND
	rental_duration % 2 = 1

--10
SELECT DISTINCT special_features	--DISTINCT nebudou vypsane duplicitni
FROM film
WHERE replacement_cost BETWEEN 14 AND 16
ORDER BY special_features         --musime neco specifikovat aby se to vypsalo abecedne

--11
SELECT *
FROM film
WHERE
	rental_duration < 4 AND rating != 'PG' OR
	rental_duration >= 4 AND rating = 'PG'
	-- rental_duration < 4 OR rating = 'PG'
	-- AND
	-- NOT (rental_duration < 4 OR rating = 'PG')	--nefunguje jak ma, spatne jsem to opsal

--12
SELECT *
FROM address
WHERE postal_code IS NOT NULL

--13
SELECT DISTINCT customer_id
FROM rental
WHERE return_date IS NULL

--14
SELECT payment_id, YEAR(payment_date) AS rok, MONTH(payment_date) AS mesic, DAY(payment_date) AS den
FROM payment

--15
SELECT *
FROM film
WHERE LEN(title) != 20

--16
SELECT rental_id, DATEDIFF(MINUTE, rental_date, return_date) AS minuty
FROM rental
WHERE return_date IS NOT NULL

--17
SELECT customer_id, (first_name + ' ' + last_name) AS full_name
FROM customer
WHERE active = 1

--18
SELECT address, COALESCE(postal_code, '(prazdne)') AS PSC
FROM address

--19
SELECT rental_id, (CAST(rental_date AS VARCHAR) + ' - ' + CAST(return_date AS VARCHAR)) AS interval
FROM rental
WHERE return_date IS NOT NULL

--20
SELECT rental_id, (CAST(rental_date AS VARCHAR) + ' - ' + COALESCE(CAST(return_date AS VARCHAR), '')) AS interval
FROM rental

--21
SELECT COUNT(*) AS pocet_filmu
FROM film

--22
SELECT COUNT(DISTINCT rating) AS pocet_kategorii
FROM film

--23
SELECT
	COUNT(*) AS pocet_adres,
	COUNT(postal_code) AS pocet_s_psc,
	COUNT(DISTINCT postal_code) AS pocet_psc	--COUNT preskakuje NULL hodnoty
FROM address

--24
SELECT
	MIN(length) AS min_length,
	MAX(length) AS max_length,
	AVG(CAST(length AS FLOAT)) AS avg_length,
	(SUM(length) / COUNT(length)) AS test
FROM film

--25
SELECT COUNT(*) AS pocet, SUM(amount) AS soucet
FROM payment
WHERE YEAR(payment_date) = 2005

--26
SELECT SUM(LEN(title)) AS pocet_znaku
FROM film
