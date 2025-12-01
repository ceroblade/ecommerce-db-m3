-- Consultas SQL (Queries)

-- 1. Búsqueda de productos por nombre y por categoría
-- Buscar productos que contengan "Smart" en el nombre o sean de la categoría 'Electrónica'
SELECT p.id, p.nombre, p.precio, c.nombre as categoria
FROM productos p
JOIN categorias c ON p.categoria_id = c.id
WHERE p.nombre ILIKE '%Smart%' OR c.nombre = 'Electrónica';


-- 2. Top 3 productos más vendidos (por cantidad total vendida)
SELECT p.nombre, SUM(do.cantidad) as total_vendido
FROM detalles_orden do
JOIN productos p ON do.producto_id = p.id
GROUP BY p.id, p.nombre
ORDER BY total_vendido DESC
LIMIT 3;


-- 3. Ventas por mes y por categoría (Monto total)
SELECT 
    TO_CHAR(o.fecha_orden, 'YYYY-MM') as mes,
    c.nombre as categoria,
    COUNT(DISTINCT o.id) as total_ordenes,
    SUM(do.subtotal) as ingresos_totales
FROM ordenes o
JOIN detalles_orden do ON o.id = do.orden_id
JOIN productos p ON do.producto_id = p.id
JOIN categorias c ON p.categoria_id = c.id
WHERE o.estado IN ('COMPLETADO', 'ENVIADO') -- Solo ventas confirmadas
GROUP BY 1, 2
ORDER BY 1 DESC, 4 DESC;


-- 4. Ticket promedio en un rango de fechas
SELECT AVG(monto_total) as ticket_promedio
FROM ordenes
WHERE fecha_orden BETWEEN '2023-10-01' AND '2023-12-31'
  AND estado IN ('COMPLETADO', 'ENVIADO');


-- 5. Stock bajo (Umbral configurable, ej: menos de 10 unidades)
SELECT nombre, cantidad_stock
FROM productos
WHERE cantidad_stock < 10
ORDER BY cantidad_stock ASC;


-- 6. Productos sin ventas (que nunca han sido pedidos)
SELECT p.nombre, p.cantidad_stock
FROM productos p
LEFT JOIN detalles_orden do ON p.id = do.producto_id
WHERE do.id IS NULL;


-- 7. Clientes frecuentes (Más de 1 orden realizada)
SELECT c.nombre, c.apellido, COUNT(o.id) as cantidad_ordenes
FROM clientes c
JOIN ordenes o ON c.id = o.cliente_id
GROUP BY c.id, c.nombre, c.apellido
HAVING COUNT(o.id) > 1
ORDER BY cantidad_ordenes DESC;


-- ==========================================
-- Transacción: Crear una nueva orden completa
-- ==========================================

BEGIN;

-- 1. Crear la orden para el cliente ID 4 (Ana)
INSERT INTO ordenes (cliente_id, fecha_orden, estado, monto_total)
VALUES (4, NOW(), 'PENDIENTE', 0)
RETURNING id; 
-- Supongamos que devuelve ID = 5

-- 2. Insertar ítems (Ana compra 2 Jeans y 1 Libro SQL)
-- Item 1: Jeans (ID 5, Precio 45)
INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario)
VALUES (5, 5, 2, 45);

-- Item 2: Libro SQL (ID 10, Precio 30)
INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario)
VALUES (5, 10, 1, 30);

-- 3. Actualizar el total de la orden
-- (2 * 45) + (1 * 30) = 90 + 30 = 120
UPDATE ordenes 
SET monto_total = 120 
WHERE id = 5;

-- 4. Descontar stock
UPDATE productos SET cantidad_stock = cantidad_stock - 2 WHERE id = 5;
UPDATE productos SET cantidad_stock = cantidad_stock - 1 WHERE id = 10;

-- 5. Registrar movimiento de inventario (Opcional)
INSERT INTO movimientos_inventario (producto_id, tipo_movimiento, cantidad, descripcion)
VALUES 
(5, 'SALIDA', 2, 'Venta Orden #5'),
(10, 'SALIDA', 1, 'Venta Orden #5');

COMMIT;
-- Si algo falla: ROLLBACK;
