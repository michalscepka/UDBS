--1a
SELECT title, COALESCE(T1.pocet_hercu, 0), T2.pocet_kategorii
FROM film
LEFT JOIN
(
	SELECT film_id, COUNT(*) AS pocet_hercu
	FROM film_actor
	GROUP BY film_id
) T1 ON T1.film_id = film.film_id
LEFT JOIN
(
	SELECT film_id, COUNT(*) AS pocet_kategorii
	FROM film_category
	GROUP BY film_id
) T2 ON T2.film_id = film.film_id

--1b
SELECT title,
	(SELECT COUNT(*) FROM film_actor WHERE film_id = film.film_id) pocet_hercu,
	(SELECT COUNT(*) FROM film_category WHERE film_id = film.film_id) pocet_kategorii
FROM film
ORDER BY pocet_hercu, pocet_kategorii ASC

--2
--CTE
WITH mensi_5 AS
(
	SELECT customer_id, COUNT(*) pocet_vypujcek_5 FROM rental
	WHERE DATEDIFF(DAY, rental_date, return_date) < 5
	GROUP BY customer_id
),
mensi_7 AS
(
	SELECT customer_id, COUNT(*) pocet_vypujcek_7 FROM rental
	WHERE DATEDIFF(DAY, rental_date, return_date) < 7
	GROUP BY customer_id
)
SELECT customer.customer_id,
	mensi_5.pocet_vypujcek_5,
	mensi_7.pocet_vypujcek_7
FROM customer
LEFT JOIN mensi_5 ON mensi_5.customer_id = customer.customer_id
LEFT JOIN mensi_7 ON mensi_7.customer_id = customer.customer_id

--4
--SELECT
--(
--	SELECT COUNT(*)
--	FROM film_actor
--	WHERE film.film_id = film_actor.film_id
--) pocet_hercu,

--FROM film

SELECT * FROM customer c
WHERE
(
	SELECT customer_id, COUNT(*) pocet_plateb FROM payment
	WHERE MONTH(payment_date) = 6 AND customer_id = c.customer_id
	GROUP BY customer_id
)

