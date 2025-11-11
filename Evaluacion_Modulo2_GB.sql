#######################################################
###### EVALUACIÓN FINAL MÓDULO 2 - Gisela Barroso #####
#######################################################

USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title AS titulo_pelicula
	FROM film;
    
    
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT DISTINCT title AS titulo_pelicula
	FROM film
    WHERE rating = 'PG-13';
    
    
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT DISTINCT title AS titulo_pelicula, description AS descripcion_pelicula
	FROM film
    WHERE description LIKE '%amazing%';
    
    
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT DISTINCT title AS titulo_pelicula
	FROM film
    WHERE length > 120;
    
    
-- 5. Recupera los nombres de todos los actores.

SELECT DISTINCT first_name AS nombre_actor
	FROM actor;
    
    
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT DISTINCT first_name AS nombre_actor, last_name AS apellido_actor
	FROM actor
    WHERE last_name LIKE '%Gibson%';
    
    
-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT DISTINCT first_name AS nombre_actor			#, actor_id (comprobación para ver que devuelve la respuesta correcta).
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
    
-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT DISTINCT title AS titulo_pelicula			#, rating (comprobación para ver que devuelve la respuesta correcta).
	FROM film
    WHERE rating NOT IN ('R', 'PG-13');
    
    
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating AS clasificacion, COUNT(film_id) AS recuento_total
	FROM film
    GROUP BY rating;
    
    
/* 10.  Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido 
junto con la cantidad de películas alquiladas. */

SELECT c.customer_id AS id_cliente, c.first_name AS nombre_cliente, c.last_name AS apellido_cliente, COUNT(r.rental_id) AS cantidad_peliculas_alquiladas
	FROM customer AS c
    LEFT JOIN rental AS r
		ON c.customer_id = r.customer_id
	GROUP BY c.customer_id;
    
    
/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
 junto con el recuento de alquileres. */
 
SELECT c.name AS nombre_categoria, COUNT(rental_id) AS recuento_alquileres
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	GROUP BY c.category_id;
    
    
/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
 muestra la clasificación junto con el promedio de duración. */
 
SELECT rating AS clasificacion, AVG(length) AS promedio_duracion_pelicula
	FROM film
    GROUP BY rating;
    
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT DISTINCT first_name AS nombre_actor, last_name AS apellido_actor
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	WHERE f.title = "Indian Love";
    
    
-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title AS titulo_pelicula				#, description (comprobación para ver que devuelve la respuesta correcta).
	FROM film
    WHERE description LIKE '% dog %' OR description LIKE '% cat %';

/* PREGUNTAR CÉSAR --> en este caso tendría problemas si la palabra está al inicio de la descripción, al final, o 
						pegada a algún signo de puntuación. Si quito los espacios serían silabas, no palabras completas...
                        mejor la opción con REGEXP? */
                        

SELECT title AS titulo_pelicula				#, description (comprobación para ver que devuelve la respuesta correcta).
	FROM film
    WHERE description REGEXP '\\bdog\\b' OR description REGEXP '\\bcat\\b';
    
    # \\b delimita las palabras para que no se confunda con partes dentro de otras palabras.
    # Se necesita la doble \ para escapar dentro de una cadena de texto.
    

-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

SELECT DISTINCT a.actor_id AS id_actor
	FROM actor AS a
	LEFT JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	WHERE fa.actor_id IS NULL;
    
-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title AS titulo_pelicula					#, release_year (comprobación para ver que devuelve la respuesta correcta).
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;		
    
    
    
-- 17.  Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT f.title AS titulo_pelicula				#, c.name (comprobación para ver que devuelve la respuesta correcta).
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = 'Family';
    
    
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT DISTINCT a.first_name AS nombre_actor, a.last_name AS apellido_actor  	#, COUNT(fa.film_id) (comprobación para ver que devuelve la respuesta correcta).
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	GROUP BY fa.actor_id
    HAVING COUNT(fa.film_id) > 10;
    
    
-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film

SELECT title AS titulo_pelicula				#, rating, length (comprobación para ver que devuelve la respuesta correcta).
	FROM film
    WHERE rating = 'R' AND length > 120;
    
    
/* 20.  Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y 
		muestra el nombre de la categoría junto con el promedio de duración. */

SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion_pelicula
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	GROUP BY c.category_id
    HAVING AVG(f.length) > 120;
    
    
/* 21.  Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
		con la cantidad de películas en las que han actuado.*/
        
SELECT DISTINCT a.first_name AS nombre_actor, COUNT(fa.film_id) AS cantidad_peliculas
	FROM actor AS a
	INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id
    HAVING COUNT(fa.film_id) >= 5;
    

/* 22.  Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
		subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
		películas correspondientes.*/
        
SELECT DISTINCT f.title AS titulo_pelicula
	FROM film AS f
    INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	WHERE rental_id IN (SELECT r2.rental_id
							FROM rental AS r2
                            WHERE DATEDIFF(r2.return_date, r2.rental_date) > 5);   
                            
				# DATEDIFF es una función, calcula la diferencia en días entre dos fechas: DATEDIFF(day, fecha_inicio, fecha_fin).
                
                
/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
 "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
 categoría "Horror" y luego exclúyelos de la lista de actores
 








