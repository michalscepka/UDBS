----1
--SELECT *
--FROM city JOIN country ON city.country_id = country.country_id

----2
--SELECT title, language.name
--FROM film JOIN language ON film.language_id = language.language_id

----3
--SELECT rental_id
--FROM rental JOIN customer ON rental.customer_id = customer.customer_id
--WHERE customer.last_name = 'SIMPSON'

----4
--SELECT address.address
--FROM customer JOIN address ON customer.address_id = address.address_id
--WHERE customer.last_name = 'SIMPSON'

----5
--SELECT first_name, last_name, address.address, address.postal_code, city.city
--FROM 
--	customer 
--	JOIN address ON customer.address_id = address.address_id
--	JOIN city ON address.city_id = city.city_id

----6
--SELECT first_name, last_name, city.city
--FROM 
--	customer 
--	JOIN address ON customer.address_id = address.address_id
--	JOIN city ON address.city_id = city.city_id

----7
--SELECT
--	rental_id,
--	staff.first_name AS staff_first_name, staff.last_name AS staff_last_name,
--	customer.first_name AS customer_first_name, customer.last_name AS customer_last_name,
--	film.title
--FROM 
--	rental
--	JOIN staff ON rental.staff_id = staff.staff_id
--	JOIN customer ON rental.customer_id = customer.customer_id
--	JOIN inventory ON rental.inventory_id = inventory.inventory_id
--	JOIN film ON inventory.film_id = film.film_id

----8
--SELECT film.title, actor.first_name, actor.last_name
--FROM
--	film
--	JOIN film_actor ON film.film_id = film_actor.film_id
--	JOIN actor ON film_actor.actor_id = actor.actor_id
--	ORDER BY film.title

----9

----10

----11
--SELECT 
--	store.store_id, store_address.address AS store_address,
--	staff.first_name, staff.last_name,
--	staff_address.address AS staff_address
--FROM
--	store
--	JOIN staff ON store.manager_staff_id = staff.staff_id
--	JOIN address store_address ON store.address_id = store_address.address_id
--	JOIN address staff_address ON staff.address_id = staff_address.address_id

--12

--13

--14

--15

--16

--17

----18
--SELECT payment.payment_id, payment.amount, rental.return_date
--FROM
--	payment
--	LEFT JOIN rental ON payment.rental_id = rental.rental_id
--	--LEFT JOIN vnejsi spojeni, pokud neco bude NULL tak to i tak vypise

----19
--SELECT language.name, film.title
--FROM
--	language
--	LEFT JOIN film ON language.language_id = film.language_id

--20
