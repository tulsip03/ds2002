SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'ACADEMY DINOSAUR';

SELECT category.name AS CategoryName, COUNT(film.film_id) AS NumberOfFilms
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

SELECT rating, AVG(rental_duration)
FROM film
GROUP BY rating;

SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS NumberOfRentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

SELECT inventory.store_id, COUNT(rental.rental_id) AS NumberOfRentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY inventory.store_id
ORDER BY NumberOfRentals DESC
LIMIT 1;

SELECT category.name AS CategoryName, COUNT(rental.rental_id) AS NumberOfRentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY NumberOfRentals DESC
LIMIT 1;

SELECT category.name AS CategoryName, AVG(film.rental_rate) AS AverageRentalCost
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT film.title, MAX(rental.rental_date) AS LastRentalDate
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
HAVING MAX(rental.rental_date) < DATE_SUB(CURDATE(), INTERVAL 1 MONTH) OR MAX(rental.rental_date) IS NULL;

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS TotalSpending
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id;

SELECT language.name AS Language, AVG(film.length) AS AverageLength
FROM film
LEFT JOIN language ON film.language_id = language.language_id
GROUP BY language.name;