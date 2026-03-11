-- 2. Películas con clasificación 'R'
SELECT title
FROM film
WHERE rating = 'R';

-- 3. Actores con actor_id entre 30 y 40
SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

-- 4. Películas cuyo idioma coincide con el idioma original
SELECT title
FROM film
WHERE language_id = original_language_id;

-- 5. Películas ordenadas por duración ascendente
SELECT title, length
FROM film
ORDER BY length ASC;

-- 6. Actores con 'Allen' en el apellido
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%Allen%';

-- 7. Número de películas por clasificación
SELECT rating, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating;

-- 8. Películas PG-13 o con duración mayor a 180 minutos
SELECT title
FROM film
WHERE rating = 'PG-13'
OR length > 180;

-- 9. Variabilidad del coste de reemplazo
SELECT VARIANCE(replacement_cost) AS variabilidad_coste
FROM film;

-- 10. Mayor y menor duración de película
SELECT 
MAX(length) AS duracion_maxima,
MIN(length) AS duracion_minima
FROM film;

-- 11. Coste del antepenúltimo alquiler
SELECT amount
FROM payment
ORDER BY payment_date DESC
OFFSET 2
LIMIT 1;

-- 12. Películas que no sean 'NC-17' ni 'G'
SELECT title
FROM film
WHERE rating NOT IN ('NC-17', 'G');

-- 13. Promedio de duración por clasificación
SELECT rating, AVG(length) AS duracion_promedio
FROM film
GROUP BY rating;

-- 14. Películas con duración mayor a 180 minutos
SELECT title
FROM film
WHERE length > 180;

-- 15. Dinero total generado
SELECT SUM(amount) AS total_ingresos
FROM payment;

-- 16. 10 clientes con mayor ID
SELECT *
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

-- 17. Actores que aparecen en la película 'Egg Igby'
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Egg Igby';

-- 18. Nombres únicos de películas
SELECT DISTINCT title
FROM film;

-- 19. Películas de comedia con duración mayor a 180 minutos
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy'
AND f.length > 180;

-- 20. Categorías con promedio de duración mayor a 110 minutos
SELECT c.name, AVG(f.length) AS promedio_duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. Media de duración del alquiler
SELECT AVG(rental_duration) AS media_duracion_alquiler
FROM film;

-- 22. Columna con nombre completo de actores
SELECT first_name || ' ' || last_name AS nombre_completo
FROM actor;

-- 23. Número de alquileres por día
SELECT DATE(rental_date) AS dia, COUNT(*) AS total_alquileres
FROM rental
GROUP BY dia
ORDER BY total_alquileres DESC;

-- 24. Películas con duración superior al promedio
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- 25. Número de alquileres por mes
SELECT DATE_TRUNC('month', rental_date) AS mes, COUNT(*) AS total_alquileres
FROM rental
GROUP BY mes
ORDER BY mes;

-- 26. Promedio, desviación estándar y varianza del total pagado
SELECT 
AVG(amount) AS promedio,
STDDEV(amount) AS desviacion_estandar,
VARIANCE(amount) AS varianza
FROM payment;

-- 27. Películas con precio de alquiler superior al promedio
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);

-- 28. Actores que han participado en más de 40 películas
SELECT actor_id, COUNT(film_id) AS total_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40;

-- 29. Todas las películas y cantidad disponible en inventario
SELECT f.title, COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;

-- 30. Actores y número de películas en las que han actuado
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY num_peliculas DESC;


-- 31. Todas las películas y los actores que han actuado en ellas
SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id;


-- 32. Todos los actores y las películas en las que han actuado
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id;


-- 33. Todas las películas y registros de alquiler
SELECT f.title, r.rental_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id;


-- 34. 5 clientes que más dinero han gastado
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_gastado DESC
LIMIT 5;


-- 35. Actores cuyo nombre es Johnny
SELECT *
FROM actor
WHERE first_name = 'Johnny';


-- 36. Renombrar columnas
SELECT first_name AS Nombre, last_name AS Apellido
FROM actor;


-- 37. ID del actor más bajo y más alto
SELECT MIN(actor_id) AS id_min, MAX(actor_id) AS id_max
FROM actor;


-- 38. Número total de actores
SELECT COUNT(*) AS total_actores
FROM actor;


-- 39. Actores ordenados por apellido
SELECT *
FROM actor
ORDER BY last_name ASC;


-- 40. Primeras 5 películas
SELECT *
FROM film
LIMIT 5;


-- 41. Agrupar actores por nombre
SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;


-- 42. Alquileres y nombres de clientes
SELECT r.rental_id, c.first_name, c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id;


-- 43. Todos los clientes y sus alquileres si existen
SELECT c.first_name, c.last_name, r.rental_id
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;


-- 44. CROSS JOIN entre film y category
SELECT f.title, c.name
FROM film f
CROSS JOIN category c;

-- Esta consulta genera todas las combinaciones posibles entre películas y categorías.
-- No suele aportar valor práctico porque produce muchas combinaciones artificiales.


-- 45. Actores que han participado en películas de categoría 'Action'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';


-- 46. Actores que no han participado en películas
SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;


-- 47. Nombre de actores y número de películas
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;


-- 48. Crear vista actor_num_peliculas
CREATE VIEW actor_num_peliculas AS
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;


-- 49. Total de alquileres por cliente
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;


-- 50. Duración total de películas de categoría 'Action'
SELECT SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 51. Tabla temporal con total de alquileres por cliente
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT customer_id, COUNT(rental_id) AS total_alquileres
FROM rental
GROUP BY customer_id;


-- 52. Tabla temporal de películas alquiladas al menos 10 veces
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.title, COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
HAVING COUNT(r.rental_id) >= 10;


-- 53. Películas alquiladas por Tammy Sanders que no han sido devueltas
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Tammy'
AND c.last_name = 'Sanders'
AND r.return_date IS NULL
ORDER BY f.title;


-- 54. Actores que han participado en películas de categoría 'Sci-Fi'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;


-- 55. Actores en películas alquiladas después del primer alquiler de 'Spartacus Cheaper'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN inventory i ON fa.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date >
(
    SELECT MIN(r2.rental_date)
    FROM film f2
    JOIN inventory i2 ON f2.film_id = i2.film_id
    JOIN rental r2 ON i2.inventory_id = r2.inventory_id
    WHERE f2.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name;


-- 56. Actores que NO han actuado en películas de categoría 'Music'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN
(
    SELECT a2.actor_id
    FROM actor a2
    JOIN film_actor fa ON a2.actor_id = fa.actor_id
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
);


-- 57. Películas alquiladas por más de 8 días
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE (r.return_date - r.rental_date) > 8;


-- 58. Películas de la misma categoría que 'Animation'
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id =
(
    SELECT category_id
    FROM category
    WHERE name = 'Animation'
);


-- 59. Películas con la misma duración que 'Dancing Fever'
SELECT title
FROM film
WHERE length =
(
    SELECT length
    FROM film
    WHERE title = 'Dancing Fever'
)
ORDER BY title;


-- 60. Clientes que han alquilado al menos 7 películas distintas
SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name;


-- 61. Total de películas alquiladas por categoría
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;


-- 62. Número de películas por categoría estrenadas en 2006
SELECT c.name, COUNT(f.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY c.name;


-- 63. Todas las combinaciones posibles de trabajadores con tiendas
SELECT s.staff_id, st.store_id
FROM staff s
CROSS JOIN store st;


-- 64. Total de películas alquiladas por cliente
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_alquileres DESC;



-- 51. Tabla temporal con total de alquileres por cliente
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT customer_id, COUNT(rental_id) AS total_alquileres
FROM rental
GROUP BY customer_id;


-- 52. Tabla temporal de películas alquiladas al menos 10 veces
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.title, COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
HAVING COUNT(r.rental_id) >= 10;


-- 53. Películas alquiladas por Tammy Sanders que no han sido devueltas
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Tammy'
AND c.last_name = 'Sanders'
AND r.return_date IS NULL
ORDER BY f.title;


-- 54. Actores que han actuado al menos en una película
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id;