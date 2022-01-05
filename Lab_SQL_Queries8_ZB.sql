-- Lab | SQL Queries 8
-- Zsanett Borsos

-- Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title, length,
DENSE_RANK() OVER(ORDER BY length) 'Rank'
FROM sakila.film
WHERE length != 0;

-- Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, 
-- only select the columns title, length, rating and the rank.
SELECT title, ROUND(AVG(length),2) AS average_length, rating,
DENSE_RANK() OVER(ORDER BY length) 'rank'
FROM sakila.film
WHERE length != 0
GROUP BY rating;
-- Having the title column makes no sense here!

-- How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT sakila.film_category.category_id, sakila.category.name, COUNT(film_id) 
FROM sakila.film_category
INNER JOIN sakila.category ON sakila.category.category_id = sakila.film_category.category_id
GROUP BY sakila.film_category.category_id;

-- Which actor has appeared in the most films?
SELECT sakila.film_actor.actor_id, sakila.actor.first_name, sakila.actor.last_name, COUNT(film_id) 
FROM sakila.film_actor
INNER JOIN sakila.actor ON sakila.actor.actor_id = sakila.film_actor.actor_id
GROUP BY sakila.film_actor.actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

-- Most active customer (the customer that has rented the most number of films)
SELECT sakila.rental.customer_id, sakila.customer.first_name, sakila.customer.last_name, COUNT(inventory_id) 
FROM sakila.rental
INNER JOIN sakila.customer ON sakila.rental.customer_id = sakila.customer.customer_id
GROUP BY sakila.customer.customer_id
ORDER BY COUNT(inventory_id) DESC
LIMIT 1;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try. 
-- We will talk about queries with multiple join statements later in the lessons.
SELECT title, sakila.inventory.inventory_id, COUNT(sakila.rental.inventory_id) FROM sakila.film
INNER JOIN sakila.inventory ON sakila.film.film_id = sakila.inventory.film_id
INNER JOIN sakila.rental ON sakila.inventory.inventory_id = sakila.rental.inventory_id
GROUP BY title
ORDER BY COUNT(sakila.rental.inventory_id) DESC
LIMIT 1;
