# Evaluación Final - Módulo 2  
**Bootcamp Data Analytics & IA**  
**Alumna:** Gisela Barroso  

---

## Descripción y base de datos utilizada

Este repositorio contiene la solución a la evaluación final del Módulo 2 del bootcamp de Data Analytics & IA.  
El objetivo principal ha sido realizar consultas SQL sobre la base de datos **sakila**, demostrando el manejo de sentencias SELECT, JOINs, funciones agregadas, subconsultas y técnicas avanzadas de SQL.

La base de datos **Sakila** es una base de datos de muestra que contiene tablas relevantes para una tienda de alquiler de películas, tales como:

- **film** (películas)  
- **actor** (actores)  
- **customer** (clientes)  
- **rental** (alquileres)  
- **category** (categorías)  
- Entre otras tablas relacionadas.

---

## Contenido

- Archivo SQL con las 25 consultas resueltas (incluye un BONUS).  
- Comentarios explicativos en cada consulta para clarificar decisiones y buenas prácticas.  
- Uso consistente de alias funcionales para mejorar la legibilidad y evitar problemas futuros en la manipulación de resultados.

---

## Instrucciones para ejecutar

1. Descargar e instalar MySQL (o utilizar un entorno que lo tenga instalado).
2. Asegurarse de tener instalada la base de datos **sakila** en MySQL, o, en su defecto, importarla.  
3. Seleccionar la base de datos con:  
   ```sql
   USE sakila;
4. Ejecutar las consultas SQL contenidas en el archivo para obtener los resultados esperados.

5. Consultar los comentarios incluidos para comprender el razonamiento detrás de cada consulta.

---

## Estructura de las consultas

Las consultas están organizadas y numeradas del 1 al 25, abordando temas tales como:

- Selección de datos sin duplicados.

- Filtrado por clasificación y duración de películas.

- Búsqueda por palabras clave en descripciones.

- Obtención de nombres completos de actores.

- Análisis estadísticos mediante funciones agregadas.

- Uso de joins para relacionar tablas.

- Subconsultas y Common Table Expressions (CTE) para consultas complejas.

---

## Buenas prácticas aplicadas

- Uso de alias funcionales para columnas y tablas (sin espacios ni caracteres especiales).

- Aplicación de DISTINCT para evitar duplicados cuando procede.

- Inclusión de comentarios explicativos para justificar decisiones en las consultas.

- Filtrado de datos preciso y uso de operadores lógicos para búsquedas específicas. 

- Empleo de subconsultas y CTE para mejorar claridad y eficiencia.

- Utilización de funciones agregadas, cláusulas GROUP BY y HAVING para análisis estadísticos.

- Correcto manejo de joins (INNER, LEFT) para relacionar tablas adecuadamente.

---

## Consulta destacada (BONUS)

Consulta que identifica todos los actores que han actuado conjuntamente en al menos una película, mostrando el número de producciones compartidas:

```sql
WITH actores_peliculas AS (SELECT a.actor_id, a.first_name, a.last_name, fa.film_id
							FROM actor AS a
                            INNER JOIN film_actor AS fa
								ON a.actor_id = fa.actor_id)		
													
SELECT 	ap1.first_name AS nombre_actor1, ap1.last_name AS apellido_actor1, 
		ap2.first_name AS nombre_actor2, ap2.last_name AS apellido_actor2, 
        COUNT(ap1.film_id) AS peliculas_juntos
	FROM actores_peliculas AS ap1
    INNER JOIN actores_peliculas AS ap2
		ON ap1.film_id = ap2.film_id								
		AND ap1.actor_id < ap2.actor_id     						
	GROUP BY 	ap1.actor_id,										
				ap2.actor_id;
```
---

## Contacto

Para cualquier consulta o comentario, puede contactarme a través de giselabagu@outlook.com.

Gisela Barroso - 
Bootcamp Data Analytics & IA