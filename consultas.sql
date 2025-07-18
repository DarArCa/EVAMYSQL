SELECT c.id_cliente, c.nombre, c.apellidos, COUNT(a.id_alquiler) AS total_alquileres
FROM alquiler a
JOIN cliente c ON a.id_cliente = c.id_cliente
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC
LIMIT 1;



SELECT p.titulo, COUNT(a.id_alquiler) AS veces_alquilada
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.id_pelicula
ORDER BY veces_alquilada DESC
LIMIT 5;

SELECT cat.nombre AS categoria, SUM(pg.total) AS ingresos, COUNT(a.id_alquiler) AS total_alquileres
FROM pago pg
JOIN alquiler a ON pg.id_alquiler = a.id_alquiler
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria cat ON pc.id_categoria = cat.id_categoria
GROUP BY cat.nombre
ORDER BY ingresos DESC;



SELECT l.nombre AS idioma, COUNT(DISTINCT a.id_cliente) AS total_clientes
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN idioma l ON p.id_idioma = l.id_idioma
WHERE MONTH(a.fecha_alquiler) = 6 AND YEAR(a.fecha_alquiler) = YEAR(CURDATE())  -- Cambia el mes
GROUP BY l.nombre;


SELECT c.id_cliente, c.nombre, c.apellidos
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
WHERE pc.id_categoria = 1 -- Cambia por la categoría
GROUP BY c.id_cliente
HAVING COUNT(DISTINCT p.id_pelicula) = (
    SELECT COUNT(*) FROM pelicula_categoria WHERE id_categoria = 1
);


SELECT ci.nombre AS ciudad, COUNT(DISTINCT c.id_cliente) AS total_clientes
FROM cliente c
JOIN direccion d ON c.id_direccion = d.id_direccion
JOIN ciudad ci ON d.id_ciudad = ci.id_ciudad
JOIN alquiler a ON c.id_cliente = a.id_cliente
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY ci.nombre
ORDER BY total_clientes DESC
LIMIT 3;


SELECT cat.nombre AS categoria, COUNT(a.id_alquiler) AS total_alquileres
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria cat ON pc.id_categoria = cat.id_categoria
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY cat.nombre
ORDER BY total_alquileres ASC
LIMIT 5;


SELECT ROUND(AVG(DATEDIFF(fecha_devolucion, fecha_alquiler)), 2) AS promedio_dias
FROM alquiler
WHERE fecha_devolucion IS NOT NULL;


SELECT e.id_empleado, e.nombre, e.apellidos, COUNT(a.id_alquiler) AS total_alquileres
FROM alquiler a
JOIN empleado e ON a.id_empleado = e.id_empleado
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria cat ON pc.id_categoria = cat.id_categoria
WHERE cat.nombre = 'Acción'
GROUP BY e.id_empleado
ORDER BY total_alquileres DESC
LIMIT 5;


SELECT c.id_cliente, c.nombre, c.apellidos, COUNT(a.id_alquiler) AS total_alquileres
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC
LIMIT 10;
