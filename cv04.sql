--1
SELECT film_id, title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id = 1
)

--pomoci EXISTS
SELECT film_id, title
FROM film
WHERE EXISTS (
	--pokud jde vnitrek EXISTS sam spustit tak je nekde neco spatne
	SELECT *
	FROM film_actor
	WHERE actor_id = 1 AND film_actor.film_id = film.film_id
)

--2
SELECT film_id
FROM film_actor
WHERE actor_id = 1

--3
SELECT film_id, title
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
SELECT film_id
FROM film
WHERE
	film_id NOT IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 1
	)

--6

--7
SELECT film_id, title
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM actor JOIN film_actor ON actor.actor_id = film_actor.actor_id
		WHERE actor.first_name = 'PENELOPE' AND actor.last_name = 'GUINESS'
	)
	AND film_id IN (
		SELECT film_id
		FROM actor JOIN film_actor ON actor.actor_id = film_actor.actor_id
		WHERE actor.first_name = 'CHRISTIAN' AND actor.last_name = 'GABLE'
	)

--10
SELECT first_name, last_name
FROM customer
WHERE 
	customer_id IN (
		SELECT customer_id
		FROM
			rental
			JOIN inventory ON rental.inventory_id = inventory.inventory_id
			JOIN film ON inventory.film_id = film.film_id
		WHERE
			film.title = 'GRIT CLOCKWORK' AND
			MONTH(rental.rental_date) = 5
	) AND customer_id IN (
		SELECT customer_id
			FROM
				rental
				JOIN inventory ON rental.inventory_id = inventory.inventory_id
				JOIN film ON inventory.film_id = film.film_id
			WHERE
				film.title = 'GRIT CLOCKWORK' AND
				MONTH(rental.rental_date) = 6
	)

--13
SELECT title
FROM film
WHERE length < ANY (
	SELECT film.length
	FROM
		actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film ON film_actor.film_id = film.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY'
)

--nebo
SELECT title
FROM film f1
WHERE EXISTS( 
	SELECT *
	FROM
		actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film f2 ON film_actor.film_id = f2.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY' AND f1.length < f2.length
)

--15
SELECT DISTINCT f1.title
FROM
	rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
WHERE EXISTS (
	SELECT *
	FROM
		rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE i2.film_id = i1.film_id AND r1.rental_id != r2.rental_id
)

--16
SELECT DISTINCT f1.title
FROM
	rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON i1.film_id = f1.film_id
WHERE EXISTS (
	SELECT *
	FROM
		rental r2
		JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
	WHERE i2.film_id = i1.film_id AND r1.customer_id != r2.customer_id
)

--19
SELECT title
FROM film
WHERE length < ALL (
	SELECT film.length
	FROM
		actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film ON film_actor.film_id = film.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY'
)

--nebo
SELECT title
FROM film f1
WHERE NOT EXISTS (
	SELECT *
	FROM
		actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film f2 ON film_actor.film_id = f2.film_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY' AND f2.length <= f1.length
)

--22
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM rental
	WHERE MONTH(rental.rental_date) NOT BETWEEN 6 AND 8
) AND customer_id IN (SELECT customer_id FROM rental)

--25
SELECT customer.first_name, customer.last_name
FROM
	rental r1
	JOIN customer ON r1.customer_id = customer.customer_id
WHERE NOT EXISTS (
	SELECT *
	FROM rental r2
	WHERE r1.customer_id = r2.customer_id AND r1.rental_id != r2.rental_id
)
