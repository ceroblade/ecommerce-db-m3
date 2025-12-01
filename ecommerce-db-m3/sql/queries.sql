-- ==========================================
-- Consultas SQL (Queries)
-- ==========================================

-- 1. Búsqueda de productos por nombre y por categoría
-- Buscar productos que contengan "Smart" en el nombre o sean de la categoría 'Electrónica'
SELECT p.id, p.name, p.price, c.name as category
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE p.name ILIKE '%Smart%' OR c.name = 'Electrónica';


-- 2. Top 3 productos más vendidos (por cantidad total vendida)
SELECT p.name, SUM(oi.quantity) as total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY total_sold DESC
LIMIT 3;


-- 3. Ventas por mes y por categoría (Monto total)
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') as month,
    c.name as category,
    COUNT(DISTINCT o.id) as total_orders,
    SUM(oi.subtotal) as total_revenue
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id
WHERE o.status IN ('COMPLETED', 'SHIPPED') -- Solo ventas confirmadas
GROUP BY 1, 2
ORDER BY 1 DESC, 4 DESC;


-- 4. Ticket promedio en un rango de fechas
SELECT AVG(total_amount) as average_ticket
FROM orders
WHERE order_date BETWEEN '2023-10-01' AND '2023-12-31'
  AND status IN ('COMPLETED', 'SHIPPED');


-- 5. Stock bajo (Umbral configurable, ej: menos de 10 unidades)
SELECT name, stock_quantity
FROM products
WHERE stock_quantity < 10
ORDER BY stock_quantity ASC;


-- 6. Productos sin ventas (que nunca han sido pedidos)
SELECT p.name, p.stock_quantity
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
WHERE oi.id IS NULL;


-- 7. Clientes frecuentes (Más de 1 orden realizada)
SELECT c.first_name, c.last_name, COUNT(o.id) as orders_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name
HAVING COUNT(o.id) > 1
ORDER BY orders_count DESC;


-- ==========================================
-- Transacción: Crear una nueva orden completa
-- ==========================================

BEGIN;

-- 1. Crear la orden para el cliente ID 4 (Ana)
INSERT INTO orders (customer_id, order_date, status, total_amount)
VALUES (4, NOW(), 'PENDING', 0)
RETURNING id; 
-- Supongamos que devuelve ID = 5

-- 2. Insertar ítems (Ana compra 2 Jeans y 1 Libro SQL)
-- Item 1: Jeans (ID 5, Precio 45.00)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (5, 5, 2, 45.00);

-- Item 2: Libro SQL (ID 10, Precio 29.99)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (5, 10, 1, 29.99);

-- 3. Actualizar el total de la orden
-- (2 * 45.00) + (1 * 29.99) = 90.00 + 29.99 = 119.99
UPDATE orders 
SET total_amount = 119.99 
WHERE id = 5;

-- 4. Descontar stock
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE id = 5;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE id = 10;

-- 5. Registrar movimiento de inventario (Opcional)
INSERT INTO inventory_movements (product_id, movement_type, quantity, description)
VALUES 
(5, 'OUT', 2, 'Venta Orden #5'),
(10, 'OUT', 1, 'Venta Orden #5');

COMMIT;
-- Si algo falla: ROLLBACK;
