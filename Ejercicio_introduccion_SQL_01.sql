-- Ejercicio 1

-- 1.1 Crear una tabla llamada "Clientes" con las columnas: id (entero, clave primaria), nombre (texto) y email (texto).
CREATE TABLE IF NOT EXISTS clientes (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (255) NOT NULL,
	email VARCHAR (255) NOT NULL
);

-- 1.2 Insertar un nuevo cliente en la tabla "Clientes" con id=1, nombre="Juan" y email="juan@example.com".
INSERT INTO public.clientes(nombre, email)
VALUES ('Juan','juan@example.com');

-- 3. Actualizar el email del cliente con id=1 a "juan@gmail.com".
UPDATE public.clientes
SET email = 'juan@gmail.com'
WHERE id = 1;

-- 4. Eliminar el cliente con id=1 de la tabla "Clientes".
DELETE FROM public.clientes
WHERE id =1;


/* 5. Crear una tabla llamada "Pedidos" con las columnas: id (entero, clave primaria), 
cliente_id (entero, clave externa referenciando a la tabla "Clientes"), producto (texto) y cantidad (entero).*/

 CREATE TABLE IF NOT EXISTS pedidos(
	id SERIAL PRIMARY KEY,
	clientes_id INT NOT NULL,
	producto VARCHAR (255) NOT NULL,
	cantidad INT NOT NULL,
	CONSTRAINT FK_clientes_id FOREIGN KEY (clientes_id) REFERENCES clientes(id)	
);

-- 6. Insertar un nuevo pedido en la tabla "Pedidos" con id=1, cliente_id=1, producto="Camiseta" y cantidad=2.
INSERT INTO public.pedidos (clientes_id, producto, cantidad)
VALUES (1, 'Camiseta', 2);
	/* ERROR:  La llave (clientes_id)=(1) no está presente en la tabla «clientes».inserción o actualización en la tabla «pedidos» viola la llave foránea «fk_clientes_id» 
	ERROR:  inserción o actualización en la tabla «pedidos» viola la llave foránea «fk_clientes_id»
	SQL state: 23503
	Detail: La llave (clientes_id)=(1) no está presente en la tabla «clientes».
	----- lógico, en el punto 4 se ha eliminado el id=1 de la tabla 'clientes' */

-- 7. Actualizar la cantidad del pedido con id=1 a 3.
UPDATE public.pedidos 
SET cantidad = 3
WHERE id = 1
	/* no da error, pero no tiene sentido al no haber en pedidos nada.*/

-- 8. Eliminar el pedido con id=1 de la tabla "Pedidos".
DELETE FROM public.pedidos
WHERE id = 1
	/* Idem anterior, no tiene sentido al no haber en pedidos nada.*/

/* 9. Crear una tabla llamada "Productos" con las columnas: id (entero, clave primaria), 
nombre (texto) y precio (decimal).*/
CREATE TABLE IF NOT EXISTS productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (255) NOT NULL,
	precio DECIMAL NOT NULL
);

-- 10. Insertar varios productos en la tabla "Productos" con diferentes valores.
INSERT INTO productos (nombre, precio)
VALUES ('Smartphone',600),
		('Smartwatch',300), 
		('earpods',190);

-- 11. Consultar todos los clientes de la tabla "Clientes".
SELECT * 
FROM "clientes";

-- 12. Consultar todos los pedidos de la tabla "Pedidos" junto con los nombres de los clientes correspondientes.
SELECT "p"."id" AS "Pedido",
		"c"."nombre" AS "Cliente"
FROM "pedidos" AS "p"
LEFT JOIN "clientes" AS "c"
ON "p"."clientes_id" = "c"."id"

-- 13. Consultar los productos de la tabla "Productos" cuyo precio sea mayor a $50.
SELECT "nombre"
FROM "productos"
WHERE "precio" >50;

-- 14. Consultar los pedidos de la tabla "Pedidos" que tengan una cantidad mayor o igual a 5.
SELECT "producto" AS "Producto"
FROM "pedidos"
WHERE cantidad >= 5;

-- 15. Consultar los clientes de la tabla "Clientes" cuyo nombre empiece con la letra "A"
SELECT "nombre" AS "Clientes"
FROM "clientes"
WHERE "nombre" LIKE 'A%';

-- 16. Realizar una consulta que muestre el nombre del cliente y el total de pedidos realizados por cada cliente.
SELECT "c"."nombre" AS "Cliente",
		COUNT("p"."id") AS "Núm. Pedidos"
FROM "clientes" AS "c"
INNER JOIN "pedidos" AS "p"
ON "c"."id" = "p"."clientes_id"
GROUP BY "Cliente";

-- 17. Realizar una consulta que muestre el nombre del producto y la cantidad total de pedidos de ese producto.
	
SELECT "p"."nombre" AS "Producto",
		COUNT("pd"."producto")
FROM "productos" AS "p"
INNER JOIN "pedidos" AS "pd"
ON "p"."nombre" = "pd"."producto"
GROUP BY "Producto";

-- 18. Agregar una columna llamada "fecha" a la tabla "Pedidos" de tipo fecha.
ALTER TABLE public.pedidos
ADD COLUMN fecha DATE NOT NULL;


/* 19. Agregar una clave externa a la tabla "Pedidos" que haga referencia a la tabla "Productos" 
en la columna "producto".*/
ALTER TABLE public.pedidos
ADD COLUMN producto_id INT NOT NULL;

ALTER TABLE public.pedidos
ADD CONSTRAINT FK_producto_id FOREIGN KEY (producto_id) REFERENCES public.productos(id);


/* 20. Realizar una consulta que muestre los nombres de los clientes, los nombres de los productos y las cantidades
de los pedidos donde coincida la clave externa. */
SELECT "c"."nombre" AS "Cliente",
		"p"."nombre" AS "Producto",
		"pd"."cantidad"
FROM "clientes" AS "c"
INNER JOIN "pedidos" AS "pd"
ON "c"."id" = "pd"."clientes_id"
INNER JOIN "productos" AS "p"
ON "pd"."producto_id" = "p"."id";
