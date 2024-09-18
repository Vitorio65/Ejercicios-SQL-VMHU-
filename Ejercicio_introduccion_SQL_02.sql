-- EJERCICIO 2
-- Nivel de dificultad: Fácil

-- 1. Crea una base de datos llamada "MiBaseDeDatos".
CREATE DATABASE "MiBaseDeDatos"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- 	2. Crea una tabla llamada "Usuarios" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "edad" (entero).
CREATE TABLE IF NOT EXISTS Usuarios (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (255) NOT NULL,
	edad INT NOT NULL
);

-- 3. Inserta dos registros en la tabla "Usuarios".
INSERT INTO public.usuarios(nombre, edad)
VALUES ('Luis García',23),
		('Pedro Pérez',39);

-- 4. Actualiza la edad de un usuario en la tabla "Usuarios".
UPDATE public.usuarios
SET edad = 29
WHERE id = 2;

-- 5. Elimina un usuario de la tabla "Usuarios".
DELETE FROM public.usuarios
WHERE id = 1;

-- Nivel de dificultad: Moderado
/* 1. Crea una tabla llamada "Ciudades" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "pais" (texto).*/
CREATE TABLE IF NOT EXISTS ciudades (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (255) NOT NULL,
	pais VARCHAR (255) NOT NULL
);

-- 2. Inserta al menos tres registros en la tabla "Ciudades".
INSERT INTO public.ciudades (nombre, pais)
VALUES ('Zaragoza','España'),
		('Edimburgo', 'Escocia'),
		('Caracas','Venezuela');
		
/* 3. Crea una foreign key en la tabla "Usuarios" que se relacione con la columna "id"
de la tabla "Ciudades".*/
ALTER TABLE public.usuarios
ADD COLUMN ciudades_id INT;

ALTER TABLE public.usuarios
ADD CONSTRAINT FK_ciudades_id FOREIGN KEY (ciudades_id) REFERENCES public.ciudades(id);


-- 4. Realiza una consulta que muestre los nombres de los usuarios junto con el
nombre de su ciudad y país (utiliza un LEFT JOIN).
SELECT "u"."nombre" AS "Usuarios",
		"c"."nombre" AS "Ciudad"
FROM "usuarios" AS "u"
LEFT JOIN "ciudades" AS "c"
ON "u"."ciudades_id" = "c"."id";


/* 5. Realiza una consulta que muestre solo los usuarios que tienen una ciudad
asociada (utiliza un INNER JOIN).*/

SELECT "u"."nombre" AS "Usuarios",
		"c"."nombre" AS "Ciudad"
FROM "usuarios" AS "u"
INNER JOIN "ciudades" AS "c"
ON "u"."ciudades_id" = "c"."id";
