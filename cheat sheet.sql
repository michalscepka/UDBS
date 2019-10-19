--CTRL + SHIFT + R = prestane se podtrhavat cervene

SELECT email		--SELECT = vyber sloupce
FROM customer		--FROM = z jake tabulky
WHERE active = 0	--WHERE = radky

--ORDER BY
ORDER BY title DESC --ASC/DESC serazeni vysledku

--datum string
WHERE payment_date >= '2006-01-01' AND amount < 2

--mnozina
WHERE rating = 'G' OR rating = 'PG' OR rating = 'PG-13'
WHERE rating IN ('G', 'PG', 'PG-13')

--LIKE porovnava atrubuty s %, '%bla' libovolny pocet znaku pred 'bla'
WHERE (title LIKE '%RAINBOW%' OR title LIKE 'TEXAS%') AND length > 70

--BETWEEN
WHERE length >= 80 AND length <= 90
WHERE length BETWEEN 80 AND 90

--DISTINCT nebudou vypsane duplicitni
SELECT DISTINCT special_features

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
AVG(CAST(film.length AS FLOAT))

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

--JOIN
FROM rental JOIN customer ON rental.customer_id = customer.customer_id

FROM
	store
	JOIN staff ON store.manager_staff_id = staff.staff_id
	JOIN address store_address ON store.address_id = store_address.address_id
	JOIN address staff_address ON staff.address_id = staff_address.address_id

--LEFT JOIN vnejsi spojeni, pokud neco bude NULL tak to i tak vypise
FROM
	payment
	LEFT JOIN rental ON payment.rental_id = rental.rental_id

--nahradi vsechny jazyky ktere nezacinaji na 'I' hodnotami NULL
SELECT film.title, language.name
FROM film LEFT JOIN language ON film.language_id = language.language_id AND language.name LIKE 'I%'

--GROUP BY 	viz cv03.sql
SELECT rating, COUNT(*) AS pocet
FROM film
GROUP BY rating

SELECT YEAR(payment_date) AS rok, MONTH(payment_date) AS mesic, SUM(amount) AS soucet
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)	--GROUP BY nezna aliasy
ORDER BY rok, mesic

--HAVING se pouziva na seskupene zaznamy, protoze WHERE se vykona driv nez seskupeni
SELECT store_id, COUNT(*) AS pocet
FROM inventory
GROUP BY store_id
HAVING COUNT(*) > 2300

--Vypište ID jazyků, pro které je nejkratší film delší než 46 minut.

--Při sestavování takového dotazu je vhodné začít jednodušší variantou, kdy si pro kazdé
--language id vypíšeme nejkratší délku filmu. Tzn. za čneme dotazem:
SELECT language_id, MIN(length)
FROM film
GROUP BY language_id
--Teprve až vidíme, že takovž dotaz funguje, přesuneme MIN(length) do klauzule HAVING,
--tzn. vysledkem je dotaz:
SELECT language_id
FROM film
GROUP BY language_id
HAVING MIN(length) > 46

