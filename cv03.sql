--1
SELECT rating, COUNT(*) AS pocet
FROM film
GROUP BY rating

2


--3
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount)

4

--5
SELECT YEAR(payment_date) AS rok, MONTH(payment_date) AS mesic, SUM(amount) AS soucet
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)	--GROUP BY nezna aliasy
ORDER BY rok, mesic

--6
SELECT store_id, COUNT(*) AS pocet
FROM inventory
GROUP BY store_id
HAVING COUNT(*) > 2300	--HAVING se pouziva na seskupene zaznamy, protoze WHERE se vykona driv nez seskupeni

7

8

--9
SELECT rating, SUM(length) AS celkova_delka		--6.
FROM film										--1.
WHERE length < 50								--2.
GROUP BY rating									--3.
HAVING SUM(length) > 250						--4.
ORDER BY rating									--5.

--10
SELECT language_id, COUNT(*) AS cnt
FROM film
GROUP BY language_id

--11
SELECT language.language_id, language.name, COUNT(*) AS cnt
FROM language JOIN film ON language.language_id = film.language_id
GROUP BY language.language_id, language.name

--12
SELECT language.language_id, language.name, COUNT(film.film_id) AS cnt
FROM language LEFT JOIN film ON language.language_id = film.language_id
GROUP BY language.language_id, language.name

13

14

--15
SELECT actor.first_name, actor.last_name
FROM 
	actor
	JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) > 20

--16
SELECT
	customer.customer_id, first_name, last_name,
	SUM(payment.amount) AS celkem, MIN(payment.amount) AS nejmensi,
	MAX(payment.amount) AS nejvetsi, AVG(payment.amount) AS prumer
FROM 
	customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
	LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id, first_name, last_name

17

18

--19
SELECT
	actor.actor_id, actor.first_name, actor.last_name,
	COUNT(DISTINCT film_category.category_id) AS pocet_katergorii
FROM
	actor
	LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
	LEFT JOIN film_category ON film_actor.film_id = film_category.film_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name

20

21

22

--23
SELECT language.name, COUNT(film.film_id) AS pocet
FROM
	language
	LEFT JOIN film ON language.language_id = film.language_id
	AND film.length > 350
GROUP BY language.name

25
SELECT *
FROM 
	