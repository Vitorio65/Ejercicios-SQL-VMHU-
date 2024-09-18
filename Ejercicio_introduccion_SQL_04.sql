-- EJERCICIO 4

/* 1. Crea una tabla llamada "Pedidos" con las columnas: "id" (entero, clave
primaria), "id_usuario" (entero, clave foránea de la tabla "Usuarios") y
"id_producto" (entero, clave foránea de la tabla "Productos").*/

CREATE TABLE IF NOT EXISTS pedidos (
	id SERIAL PRIMARY KEY,
	usuarios_id INT NOT NULL,
	productos_id INT NOT NULL,
	CONSTRAINT FK_usuarios_id FOREIGN KEY (usuarios_id) REFERENCES usuarios(id),
	CONSTRAINT FK_productos_id FOREIGN KEY (productos_id) REFERENCES productos(id)
);

-- 2. Inserta al menos tres registros en la tabla "Pedidos" que relacionen usuarios con
productos.
INSERT INTO pedidos (usuarios_id, productos_id)
VALUES (2,1),
		(3,5),
		(2,1),
		(3,4);

/* 3. Realiza una consulta que muestre los nombres de los usuarios y los nombres de
los productos que han comprado, incluidos aquellos que no han realizado
ningún pedido (utiliza LEFT JOIN y COALESCE).*/
SELECT "u"."nombre" AS "Usuario",
		COALESCE ("p"."nombre", 'Sin producto') AS "Producto"
FROM "usuarios" AS "u"
LEFT JOIN "pedidos" AS "pd"
ON "u"."id" = "pd"."usuarios_id"
LEFT JOIN "productos" AS "p"
ON "pd"."productos_id" = "p"."id";

/* 4. Realiza una consulta que muestre los nombres de los usuarios que han
realizado un pedido, pero también los que no han realizado ningún pedido
(utiliza LEFT JOIN).*/
SELECT "u"."nombre" AS "Usuario"
FROM "usuarios" AS "u"
LEFT JOIN "pedidos" AS "pd"
ON "u"."id" = "pd"."usuarios_id"
LEFT JOIN "productos" AS "p"
ON "pd"."productos_id" = "p"."id";


/* 5. Agrega una nueva columna llamada "cantidad" a la tabla "Pedidos" y actualiza
los registros existentes con un valor (utiliza ALTER TABLE y UPDATE)*/
ALTER TABLE public.pedidos
ADD COLUMN cantidad INT;

UPDATE public.pedidos 
SET "cantidad" = 1
WHERE  "cantidad" IS NULL;


