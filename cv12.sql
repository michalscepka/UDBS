--Q1
SELECT customer_id, payment_id
FROM payment
WHERE amount = 11.99

CREATE INDEX ix_payment_amount ON payment(amount)

--Q2
SELECT customer_id, payment_id
FROM payment
WHERE amount = 10.99

--Q3
SELECT customer_id, payment_id
FROM payment
WHERE ABS(amount) * 2 = 23.98	--neni schopny pouzit index

SELECT customer_id
FROM payment
WHERE amount * 2 BETWEEN 20 AND 25

SELECT customer_id
FROM payment
WHERE amount BETWEEN 10 AND 12.5

--Q4
SELECT film_id, title
FROM film
WHERE SUBSTRING(title, 1, 2) = 'AC'

SELECT film_id, title
FROM film
WHERE title LIKE 'AC%'

CREATE INDEX ix_film_title ON Film(title)
DROP INDEX ix_film_title ON film
CREATE INDEX ix_film_title ON Film(title, film_id)

-- Q5
SELECT customer_id, rental_date, return_date
FROM rental r
WHERE 
	customer_id = 107 AND
	return_date >= '2005-08-04' AND
	return_date <= '2005-08-05'

--Q6
SELECT customer_id, rental_date, return_date
FROM rental r
WHERE
	return_date >= '2005-10-01' AND
	return_date <= '2005-10-31'

CREATE INDEX ix ON rental(return_date, customer_id, rental_date)
