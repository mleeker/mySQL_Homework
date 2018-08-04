USE sakila;
#1A
SELECT first_name, last_name FROM actor
#1B
SELECT CONCAT_WS(first_name, " ", last_name) AS 'Actor Name'
FROM actor 
#2A
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'JOE'
#2B
SELECT last_name FROM actor
WHERE last_name LIKE '%GEN%'
#2C
SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%LI%'
#2D
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China')
#3A
ALTER TABLE actor
ADD COLUMN description BLOB
#3B
ALTER TABLE actor
DROP COLUMN description
#4A
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
#4B
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
WHERE COUNT(last_name) > 1
#4C
SELECT * FROM actor
WHERE first_name = 'HARPO'
UPDATE actor
SET first_name = 'GROUCHO'

#4D
SELECT * FROM actor
WHERE first_name = 'GROUCHO'
UPDATE actor
SET first_name = 'HARPO'

#5A
CREATE TABLE address(
);

#6A
SELECT address.address_id, address.address, 
staff.address_id, staff.first_name, staff.last_name
FROM staff
INNER JOIN address ON
address.address_id = staff.address_id;

#6B
SELECT SUM(payment.amount), staff.staff_id, staff.first_name, staff.last_name, 
payment.staff_id, payment.payment_date, payment.amount
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
WHERE payment_date LIKE '2005%'
GROUP BY staff.staff_id

#6C
SELECT COUNT(film_actor.actor_id), film_actor.film_id, film.film_id, film.title
FROM film
INNER JOIN film_actor ON 
film.film_id = film_actor.film_id
GROUP BY film.title

#6D
SELECT film.film_id, film.title, COUNT(inventory.film_id)
FROM film
INNER JOIN inventory ON
film.film_id = inventory.film_id
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'

#6E
SELECT SUM(payment.amount), customer.last_name
FROM customer
INNER JOIN payment ON
payment.customer_id = customer.customer_id
GROUP BY customer.last_name

#7A
SELECT film.title, language.name 
FROM film 
INNER JOIN language ON
film.language_id = language.language_id
WHERE 
(language.name = 'English') AND
(film.title LIKE 'K%') OR
(film.title LIKE 'Q%')

#7B
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN
	(SELECT actor_id 
    FROM film_actor
    WHERE film_id IN
		(SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'))
        
#7C
SELECT customer.first_name, customer.last_name, customer.email FROM customer
INNER JOIN address ON
customer.address_id = address.address_id
INNER JOIN city ON
city.city_id = address.city_id
INNER JOIN country ON
country.country_id = city.city_id
WHERE country.country = 'CANADA'

#7D
SELECT * FROM film
WHERE rating = 'G' OR
rating = 'PG'

#7E
SELECT COUNT(rental.inventory_id), film.title FROM rental
INNER JOIN inventory ON
rental.inventory_id = inventory.inventory_id
INNER JOIN film ON
film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY COUNT(rental.inventory_id) DESC

#7F
SELECT store.store_id, CONCAT('$', (SUM(payment.amount))) FROM store
INNER JOIN customer ON
customer.store_id = store.store_id
INNER JOIN payment ON
payment.customer_id = customer.customer_id

#7G
SELECT store.store_id, city.city, country.country FROM store
INNER JOIN customer ON
store.store_id = customer.store_id
INNER JOIN address ON 
customer.address_id = address.address_id
INNER JOIN city ON
address.city_id = city.city_id
INNER JOIN country ON
city.country_id = country.country_id

#7H
SELECT category.name, SUM(payment.amount) FROM category
INNER JOIN film_category ON
category.category_id = film_category.category_id 
INNER JOIN inventory ON
film_category.film_id = inventory.film_id
INNER JOIN rental ON
inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON
rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5

#8A
CREATE TABLE top_five_genre (
SELECT category.name, SUM(payment.amount) FROM category
INNER JOIN film_category ON
category.category_id = film_category.category_id 
INNER JOIN inventory ON
film_category.film_id = inventory.film_id
INNER JOIN rental ON
inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON
rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5)

#8B
SELECT * FROM top_five_genre

#8C
DROP TABLE top_five_genre