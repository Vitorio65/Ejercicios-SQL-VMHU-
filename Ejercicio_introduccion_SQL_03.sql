-- EJERCICIO 3

/* 1. Crea una tabla llamada "Productos" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "precio" (numérico).*/
CREATE TABLE IF NOT EXISTS productos (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (255) NOT NULL,
	precio INT NOT NULL
);

-- 2. Inserta al menos cinco registros en la tabla "Productos".
INSERT INTO public.productos (nombre, precio)
VALUES ('Camiseta', 20),
		('Chandal', 50),
		('Zapatillas', 100),
		('Cortavienos',75),
		('Gorra',15);

-- 3. Actualiza el precio de un producto en la tabla "Productos".
UPDATE public.productos
SET "precio" = 17
WHERE "nombre" = 'Gorra';

-- 4. Elimina un producto de la tabla "Productos".
DELETE FROM public.productos
WHERE id = 3;

/* 5. Realiza una consulta que muestre los nombres de los usuarios junto con los
nombres de los productos que han comprado (utiliza un INNER JOIN con la
tabla "Productos").*/

-- ** NO SE HA PEDIDO CREAR NINGUNA TABLA DE PRODUCTOS. SE PODRÍA CREAR UNA TABLA QUE UNIERA AMBAS. Pero si existiera, podría quedar:
CREATE TABLE IF NOT EXISTS usuarios_productos (
	usuarios_id INT NOT NULL,
	productos_id INT NOT NULL,
	CONSTRAINT FK_usuarios_id FOREIGN KEY (usuarios_id) REFERENCES usuarios(id),
	CONSTRAINT FK_productos_id FOREIGN KEY (productos_id) REFERENCES productos(id)
);

-- Y LUEGO

SELECT "u"."nombre" AS "Usuario",
		"p"."nombre" AS "Producto"
FROM "usuarios" AS "u"
INNER JOIN "usuarios_productos" AS "uc"
ON "u"."id" = "uc"."usuarios_id"
INNER JOIN "productos" AS "p"
on "uc"."productos_id" = "p"."id";
