--1
	--IN
SELECT film_id, title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id = 1
)

	--EXISTS
SELECT film_id, title
FROM film
WHERE EXISTS (
	--pokud jde vnitrek EXISTS sam spustit tak je nekde neco spatne
	SELECT *
	FROM film_actor
	WHERE film.film_id = film_actor.film_id AND actor_id = 1
)

--2
SELECT film_id
FROM film_actor
WHERE actor_id = 1

--3
	--IN
SELECT *
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 1
	)
	AND film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 10
	)

	--EXISTS
SELECT film_id, title
FROM film
WHERE
	EXISTS (
		SELECT *
		FROM film_actor
		WHERE film.film_id = film_actor.film_id AND actor_id = 1
	)
	AND	EXISTS (
		SELECT *
		FROM film_actor
		WHERE film.film_id = film_actor.film_id AND actor_id = 10
	)

--4
SELECT film_id, title
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 1
	)
	OR film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 10
	)

	--nebo
SELECT film_id, title
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 1 OR actor_id = 10
	)

--5
	--IN
SELECT film_id
FROM film
WHERE film_id NOT IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id = 1
)

	--EXISTS
SELECT film_id
FROM film
WHERE NOT EXISTS (
	SELECT film_id
	FROM film_actor
	WHERE film.film_id = film_actor.film_id AND actor_id = 1
)

--6
SELECT film_id, title
FROM film
WHERE 
	film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 1 OR actor_id = 10
	)
	AND NOT (
		film_id IN (
			SELECT film_id
			FROM film_actor
			WHERE actor_id = 1
		)
		AND
		film_id IN (
			SELECT film_id
			FROM film_actor
			WHERE actor_id = 10
		)
	)

--7
SELECT film_id, title
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM actor
			JOIN film_actor ON actor.actor_id = film_actor.actor_id
		WHERE (actor.first_name + ' ' + actor.last_name) = 'PENELOPE GUINESS'
	)
	AND film_id IN (
		SELECT film_id
		FROM actor
			JOIN film_actor ON actor.actor_id = film_actor.actor_id
		WHERE (actor.first_name + ' ' + actor.last_name) = 'CHRISTIAN GABLE'
	)

--8
SELECT film_id, title
FROM film
WHERE film_id NOT IN (
	SELECT film_id
	FROM actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
	WHERE actor.first_name = 'PENELOPE' AND actor.last_name = 'GUINESS'
)

--9
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
WHERE
	customer_id IN (
		SELECT customer_id
		FROM rental
			JOIN inventory ON rental.inventory_id = inventory.inventory_id
			JOIN film ON inventory.film_id = film.film_id
		WHERE film.title = 'ENEMY ODDS'
	)
	AND customer_id IN (
		SELECT customer_id
		FROM rental
			JOIN inventory ON rental.inventory_id = inventory.inventory_id
			JOIN film ON inventory.film_id = film.film_id
		WHERE film.title = 'POLLOCK DELIVERANCE'
	)
	AND customer_id IN (
		SELECT customer_id
		FROM rental
			JOIN inventory ON rental.inventory_id = inventory.inventory_id
			JOIN film ON inventory.film_id = film.film_id
		WHERE film.title = 'FALCON VOLUME'
	)

--10
SELECT customer.first_name, customer.last_name
FROM customer
WHERE
	customer_id IN (
		SELECT customer_id
		FROM rental
			JOIN inventory ON rental.inventory_id = inventory.inventory_id
			JOIN film ON inventory.film_id = film.film_id
		WHERE
			film.title = 'GRIT CLOCKWORK' AND
			MONTH(rental_date) = 5
	)
	AND customer_id IN (
	SELECT customer_id
	FROM rental
		JOIN inventory ON rental.inventory_id = inventory.inventory_id
		JOIN film ON inventory.film_id = film.film_id
	WHERE
		film.title = 'GRIT CLOCKWORK' AND
		MONTH(rental_date) = 6
)

--11
SELECT first_name, last_name
FROM customer
WHERE customer.last_name IN (
	SELECT last_name
	FROM actor
)

SELECT first_name, last_name
FROM customer
WHERE EXISTS (
	SELECT *
	FROM actor
	WHERE actor.last_name = customer.last_name
)

--12
	--IN
SELECT title
FROM film f1
WHERE length IN (
	SELECT length
	FROM film f2
	WHERE f1.film_id != f2.film_id
)

	--EXISTS
SELECT title
FROM film f1
WHERE EXISTS (
	SELECT *
	FROM film f2
	WHERE
		f1.length = f2.length AND
		f1.film_id != f2.film_id
)

--13
SELECT title
FROM film
WHERE length < ANY (
	SELECT film.length
	FROM actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film ON film_actor.film_id = film.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY'
)

	--nebo
SELECT title
FROM film f1
WHERE EXISTS ( 
	SELECT *
	FROM
		actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film f2 ON film_actor.film_id = f2.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY' AND f1.length < f2.length
)

--14
SELECT actor.first_name, actor.last_name
FROM actor
WHERE 50 > ANY (
	SELECT length
	FROM film JOIN film_actor ON film.film_id = film_actor.film_id
	WHERE film_actor.actor_id = actor.actor_id
)

--15
SELECT DISTINCT f1.title
FROM rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
WHERE EXISTS (
	SELECT *
	FROM rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE i2.film_id = i1.film_id AND r1.rental_id != r2.rental_id
)

--16
SELECT DISTINCT f1.title
FROM rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
WHERE EXISTS (
	SELECT *
	FROM rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE i2.film_id = i1.film_id AND r1.customer_id != r2.customer_id
)

--17
SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name
FROM rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN customer ON r1.customer_id = customer.customer_id
WHERE EXISTS (
	SELECT *
	FROM rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE
		r1.customer_id = r2.customer_id AND
		i1.film_id != i2.film_id AND
		r1.return_date >= r2.rental_date AND
		r1.rental_date <= r2.return_date
)

--18
SELECT customer.first_name, customer.last_name
FROM customer
	JOIN rental r1 ON customer.customer_id = r1.customer_id
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
WHERE 
	f1.title = 'GRIT CLOCKWORK'
	AND MONTH(r1.rental_date) = 5
	AND EXISTS (
		SELECT *
		FROM rental r2
			JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
			JOIN film f2 ON i2.film_id = f2.film_id
		WHERE
			r1.customer_id = r2.customer_id
			AND f2.title = 'GRIT CLOCKWORK'
			AND MONTH(r2.rental_date) = 6
			AND YEAR(r1.rental_date) = YEAR(r2.rental_date)
	)

--19
	--ALL
SELECT title
FROM film
WHERE length < ALL (
	SELECT film.length
	FROM actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film ON film_actor.film_id = film.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY'
)

	--EXISTS
SELECT title
FROM film f1
WHERE NOT EXISTS (
	SELECT *
	FROM actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film f2 ON film_actor.film_id = f2.film_id
	WHERE
		actor.first_name = 'BURT' AND actor.last_name = 'POSEY' AND
		f2.length <= f1.length
)

--20
	--ALL
SELECT actor.first_name, actor.last_name
FROM actor
WHERE 180 > ALL (
	SELECT length
	FROM film JOIN film_actor ON film.film_id = film_actor.film_id
	WHERE film_actor.actor_id = actor.actor_id
)
AND actor_id IN (SELECT actor_id FROM film_actor)

	--NOT EXISTS
SELECT actor.first_name, actor.last_name
FROM actor
WHERE NOT EXISTS (
	SELECT *
	FROM film JOIN film_actor ON film.film_id = film_actor.film_id
	WHERE film_actor.actor_id = actor.actor_id AND film.length >= 180
)
AND actor_id IN (SELECT actor_id FROM film_actor)

--21
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM rental
	GROUP BY customer_id, MONTH(rental_date)
	HAVING COUNT(*) > 3
)

--22
	--NOT IN
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM rental
	WHERE MONTH(rental.rental_date) NOT BETWEEN 6 AND 8
)
AND customer_id IN (SELECT customer_id FROM rental)

	--NOT EXISTS
SELECT first_name, last_name
FROM customer
WHERE NOT EXISTS (
	SELECT *
	FROM rental
	WHERE
		customer.customer_id = rental.customer_id AND
		MONTH(rental.rental_date) NOT BETWEEN 6 AND 8
) AND customer_id IN (SELECT customer_id FROM rental)

--23
	--NOT IN
SELECT *
FROM customer
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM rental
	WHERE DATEDIFF(DAY, rental_date, return_date) > 8
)
AND customer_id IN (SELECT customer_id FROM rental)

	--NOT EXISTS
SELECT *
FROM customer
WHERE NOT EXISTS (
	SELECT *
	FROM rental
	WHERE
		rental.customer_id = customer.customer_id AND
		DATEDIFF(day, rental.rental_date, rental.return_date) > 8
)
AND customer_id IN (
	SELECT customer_id
	FROM rental
)

--24
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM rental
	WHERE DATEDIFF(DAY, rental_date, return_date) <= 1
)
AND customer_id IN (
	SELECT customer_id
	FROM rental
		JOIN inventory i1 ON rental.inventory_id = i1.inventory_id
		JOIN film ON i1.film_id = film.film_id
		JOIN film_actor ON film.film_id = film_actor.film_id
		JOIN actor ON film_actor.actor_id = actor.actor_id
	WHERE actor.first_name = 'DEBBIE' AND actor.last_name = 'AKROYD'
)

--25
SELECT customer.first_name, customer.last_name
FROM rental r1
	JOIN customer ON r1.customer_id = customer.customer_id
WHERE NOT EXISTS (
	SELECT *
	FROM rental r2
	WHERE r1.customer_id = r2.customer_id AND
	r1.rental_id != r2.rental_id
)
	--agregace
SELECT customer.first_name, customer.last_name
FROM rental
	JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(*) = 1

--26
SELECT f1.film_id, f1.title
FROM film f1
	JOIN film_actor fa1 ON f1.film_id = fa1.film_id
WHERE NOT EXISTS (
	SELECT *
	FROM film_actor fa2
	WHERE
		fa1.film_id = fa2.film_id AND
		fa1.actor_id != fa2.actor_id
)

	--agregace
SELECT film.film_id, film.title
FROM film
	JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id, film.title
HAVING COUNT(*) = 1

--27
SELECT DISTINCT customer.first_name, customer.last_name
FROM rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN customer ON r1.customer_id = customer.customer_id
WHERE NOT EXISTS (
	SELECT *
	FROM rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE r1.customer_id = r2.customer_id AND i1.film_id != i2.film_id
)

	--agregace
SELECT customer.first_name, customer.last_name
FROM rental
	JOIN customer ON rental.customer_id = customer.customer_id
	JOIN inventory ON inventory.inventory_id = rental.inventory_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT inventory.film_id) = 1

--28
SELECT DISTINCT f1.title
FROM rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
	JOIN customer ON r1.customer_id = customer.customer_id
WHERE NOT EXISTS (
	SELECT *
	FROM rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE
		r1.customer_id = r2.customer_id AND
		i1.film_id != i2.film_id
)

--29
SELECT DISTINCT customer.first_name, customer.last_name, language.name
FROM rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
	JOIN customer ON r1.customer_id = customer.customer_id
	JOIN language ON f1.language_id = language.language_id
WHERE NOT EXISTS (
	SELECT *
	FROM rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
		JOIN film f2 ON i2.film_id = f2.film_id
	WHERE
		r1.customer_id = r2.customer_id AND
		f1.language_id != f2.language_id
)

	--agregace
SELECT customer.first_name, customer.last_name, MIN(language.name) AS name
FROM customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
	LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
	LEFT JOIN film ON inventory.film_id = film.film_id
	LEFT JOIN language ON film.language_id = language.language_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT language.language_id) = 1

--30
SELECT title
FROM film
WHERE 
	film_id NOT IN
	(
		SELECT i1.film_id
		FROM rental r1
			JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
		WHERE EXISTS (
			SELECT *
			FROM rental r2
				JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
			WHERE
				r1.customer_id = r2.customer_id AND
				i1.film_id != i2.film_id
		)
	)
	AND film_id IN (
		SELECT film_id
		FROM inventory
			JOIN rental ON inventory.inventory_id = rental.inventory_id
	)

--31
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT DISTINCT customer_id
	FROM rental
		JOIN inventory ON rental.inventory_id = inventory.inventory_id
	WHERE film_id NOT IN (
		SELECT film_id
		FROM film_actor
			JOIN actor ON film_actor.actor_id = actor.actor_id
		WHERE first_name = 'CHRISTIAN' AND last_name = 'GABLE'
	)
)
AND customer_id IN (SELECT customer_id FROM rental)

--32
SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
	SELECT film_actor.actor_id
	FROM film
		JOIN film_actor ON film.film_id = film_actor.film_id
		LEFT JOIN inventory ON film.film_id = inventory.film_id
	GROUP BY film.film_id, film_actor.actor_id
	HAVING COUNT(*) < 3
) AND actor_id IN (SELECT actor_id FROM film_actor)

--33
SELECT title
FROM film
WHERE film_id NOT IN (
	SELECT inventory.film_id
	FROM inventory
		LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
	GROUP BY inventory.inventory_id, inventory.film_id
	HAVING COUNT(rental.rental_id) < 4
) AND film_id IN (SELECT film_id FROM inventory)

--34
SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
	SELECT film_actor.actor_id
	FROM film_actor
		JOIN film ON film_actor.film_id = film.film_id
	WHERE film.length < SOME (
		SELECT film.length
		FROM actor
			JOIN film_actor ON actor.actor_id = film_actor.actor_id
			JOIN film ON film_actor.film_id = film.film_id
		WHERE
			actor.first_name = 'CHRISTIAN' AND
			actor.last_name = 'GABLE'
	)
)  AND actor_id IN (SELECT actor_id FROM film_actor)

--35
SELECT actor.actor_id, first_name, last_name
FROM actor
WHERE NOT EXISTS (
	SELECT film_actor.actor_id
	FROM film_actor
		JOIN film ON film_actor.film_id = film.film_id
		JOIN inventory i1 ON film.film_id = i1.film_id
		JOIN rental r1 ON i1.inventory_id = r1.inventory_id
		JOIN customer c1 ON r1.customer_id = c1.customer_id
		JOIN address a1 ON c1.address_id = a1.address_id
		JOIN city ct1 ON a1.city_id = ct1.city_id
	WHERE
		film_actor.actor_id = actor.actor_id AND
		film.length > 180 AND
		EXISTS (
			SELECT *
			FROM inventory i2
				JOIN rental r2 ON i2.inventory_id = r2.inventory_id
				JOIN customer c2 ON r2.customer_id = c2.customer_id
				JOIN address a2 ON c2.address_id = a2.address_id
				JOIN city ct2 ON a2.city_id = ct2.city_id
			WHERE i2.film_id = i1.film_id AND ct2.country_id != ct1.country_id
		)
)
