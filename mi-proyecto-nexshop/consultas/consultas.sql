-- ============================================================
--  NexShop Group S.A. — Consultas MySQL
--  Autor: Erik Mora
--  Fichero: consultas.sql
--  Descripcion: Batería de 14 consultas sobre el modelo
--               relacional de NexShop. Cada consulta incluye
--               un comentario explicativo de una línea.
-- ============================================================

USE nexshop;

-- ============================================================
-- CONSULTA 1
-- Objetivo: Mostrar todos los empleados con su sede asignada.
-- ============================================================
-- Devuelve el listado completo de empleados con todos sus campos.
SELECT * FROM empleados;


-- ============================================================
-- CONSULTA 2
-- Objetivo: Ver solo nombre, email y fecha de registro de clientes.
-- ============================================================
-- Muestra nombre, apellidos, email y fecha de registro de los clientes registrados en la plataforma online.
SELECT nombre, apellidos, email, fecha_registro
FROM clientes;


-- ============================================================
-- CONSULTA 3
-- Objetivo: Filtrar pedidos online que están en estado 'pendiente'.
-- ============================================================
-- Devuelve los pedidos cuyo estado es 'pendiente', útil para la cola de trabajo del equipo de logística.
SELECT id_pedido, id_cliente, fecha_pedido, total
FROM pedidos_online
WHERE estado = 'pendiente';


-- ============================================================
-- CONSULTA 4
-- Objetivo: Buscar productos cuyo nombre contenga la palabra 'Gaming'.
-- ============================================================
-- Filtra productos usando LIKE para localizar referencias gaming en el catálogo.
SELECT id_producto, referencia, nombre, pvp_actual
FROM productos
WHERE nombre LIKE '%Gaming%' OR nombre LIKE '%gaming%';


-- ============================================================
-- CONSULTA 5
-- Objetivo: Buscar clientes cuyo nombre empiece por la letra 'A'.
-- ============================================================
-- Útil para localizar clientes en campañas segmentadas por nombre.
SELECT id_cliente, nombre, apellidos, email
FROM clientes
WHERE nombre LIKE 'A%';


-- ============================================================
-- CONSULTA 6
-- Objetivo: Pedidos realizados en un rango de fechas concreto.
-- ============================================================
-- Lista los pedidos online realizados entre el 1 de marzo y el 31 de mayo de 2024.
SELECT id_pedido, id_cliente, fecha_pedido, estado, total
FROM pedidos_online
WHERE fecha_pedido BETWEEN '2024-03-01' AND '2024-05-31 23:59:59';


-- ============================================================
-- CONSULTA 7
-- Objetivo: Filtrar productos cuyo PVP esté entre dos valores numéricos.
-- ============================================================
-- Devuelve productos con precio entre 100€ y 500€, útil para filtros de rango de precio en la tienda online.
SELECT id_producto, referencia, nombre, pvp_actual
FROM productos
WHERE pvp_actual BETWEEN 100.00 AND 500.00
ORDER BY pvp_actual;


-- ============================================================
-- CONSULTA 8
-- Objetivo: Lineas de pedido con cantidad superior a 1 unidad.
-- ============================================================
-- Detecta líneas donde se han pedido más de 1 unidad, para revisión de stock prioritaria.
SELECT lp.id_linea, lp.id_pedido, p.nombre AS producto, lp.cantidad, lp.precio_unit
FROM lineas_pedido lp
JOIN productos p ON lp.id_producto = p.id_producto
WHERE lp.cantidad > 1;


-- ============================================================
-- CONSULTA 9
-- Objetivo: Pedidos ordenados del más antiguo al más reciente (ASC).
-- ============================================================
-- Ordena todos los pedidos online cronológicamente, útil para auditorías históricas.
SELECT id_pedido, id_cliente, fecha_pedido, estado, total
FROM pedidos_online
ORDER BY fecha_pedido ASC;


-- ============================================================
-- CONSULTA 10
-- Objetivo: Productos ordenados de mayor a menor precio (DESC).
-- ============================================================
-- Lista el catálogo completo de mayor a menor PVP para revisión de precios.
SELECT referencia, nombre, pvp_actual
FROM productos
ORDER BY pvp_actual DESC;


-- ============================================================
-- CONSULTA 11
-- Objetivo: Clientes ordenados alfabéticamente por nombre (A-Z).
-- ============================================================
-- Ordena la base de clientes por nombre de forma ascendente para informes o exportaciones.
SELECT id_cliente, nombre, apellidos, email
FROM clientes
ORDER BY nombre ASC, apellidos ASC;


-- ============================================================
-- CONSULTA 12
-- Objetivo: Actualizar el estado de un pedido concreto con UPDATE.
-- ============================================================
-- Cambia el estado del pedido #7 (pendiente -> confirmado) al ser procesado manualmente por operaciones.
UPDATE pedidos_online
SET estado = 'confirmado'
WHERE id_pedido = 7;

-- Verificación del cambio:
SELECT id_pedido, estado FROM pedidos_online WHERE id_pedido = 7;


-- ============================================================
-- CONSULTA 13
-- Objetivo: Actualizar el email de un cliente identificado por su ID.
-- ============================================================
-- Modifica el email del cliente con id_cliente = 5 tras solicitud de cambio de datos.
UPDATE clientes
SET email = 'eva.perez.nuevo@email.com'
WHERE id_cliente = 5;

-- Verificación del cambio:
SELECT id_cliente, nombre, email FROM clientes WHERE id_cliente = 5;


-- ============================================================
-- CONSULTA 14
-- Objetivo: JOIN entre dos tablas — pedidos junto con el nombre del cliente.
-- ============================================================
-- Combina pedidos_online con clientes para mostrar en cada pedido el nombre completo del cliente.
SELECT
    po.id_pedido,
    CONCAT(c.nombre, ' ', c.apellidos) AS cliente,
    po.fecha_pedido,
    po.estado,
    po.total
FROM pedidos_online po
JOIN clientes c ON po.id_cliente = c.id_cliente
ORDER BY po.fecha_pedido DESC;
