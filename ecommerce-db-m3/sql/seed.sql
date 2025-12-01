-- ==========================================
-- Seed Data (Datos de Prueba)
-- ==========================================

-- Insertar Categorías
INSERT INTO categories (name, description) VALUES
('Electrónica', 'Dispositivos electrónicos, gadgets y accesorios.'),
('Ropa', 'Vestimenta para hombres, mujeres y niños.'),
('Hogar', 'Artículos para la decoración y uso en el hogar.'),
('Libros', 'Libros físicos y digitales de diversos géneros.');

-- Insertar Productos
-- Electrónica
INSERT INTO products (category_id, name, price, stock_quantity) VALUES
(1, 'Smartphone X', 699.99, 50),
(1, 'Laptop Pro', 1299.50, 30),
(1, 'Auriculares Bluetooth', 59.90, 100);

-- Ropa
INSERT INTO products (category_id, name, price, stock_quantity) VALUES
(2, 'Camiseta Básica', 15.00, 200),
(2, 'Jeans Clásicos', 45.00, 150),
(2, 'Zapatillas Deportivas', 89.99, 80);

-- Hogar
INSERT INTO products (category_id, name, price, stock_quantity) VALUES
(3, 'Lámpara de Escritorio', 25.50, 60),
(3, 'Juego de Sábanas', 35.00, 40);

-- Libros
INSERT INTO products (category_id, name, price, stock_quantity) VALUES
(4, 'El Señor de los Anillos', 20.00, 10), -- Stock bajo intencional
(4, 'Aprende SQL en 10 días', 29.99, 5);  -- Stock bajo intencional

-- Producto sin ventas (para probar consulta)
INSERT INTO products (category_id, name, price, stock_quantity) VALUES
(1, 'Tablet Antigua', 150.00, 10);

-- Insertar Clientes
INSERT INTO customers (first_name, last_name, email, address) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', 'Av. Siempre Viva 123'),
('María', 'Gómez', 'maria.gomez@email.com', 'Calle Falsa 456'),
('Carlos', 'López', 'carlos.lopez@email.com', 'Boulevard Central 789'),
('Ana', 'Martínez', 'ana.martinez@email.com', 'Plaza Mayor 101');

-- Insertar Órdenes y Detalle (Histórico)

-- Orden 1: Juan Pérez compra electrónica
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2023-10-01 10:00:00', 'COMPLETED', 759.89);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 699.99), -- 1 Smartphone
(1, 3, 1, 59.90);  -- 1 Auriculares

INSERT INTO payments (order_id, payment_date, amount, payment_method) VALUES
(1, '2023-10-01 10:05:00', 759.89, 'CREDIT_CARD');


-- Orden 2: María Gómez compra ropa
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(2, '2023-10-05 15:30:00', 'SHIPPED', 104.99);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(2, 2, 1, 15.00),  -- 1 Camiseta
(2, 6, 1, 89.99);  -- 1 Zapatillas

INSERT INTO payments (order_id, payment_date, amount, payment_method) VALUES
(2, '2023-10-05 15:35:00', 104.99, 'PAYPAL');


-- Orden 3: Juan Pérez compra más cosas (Cliente frecuente)
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2023-11-10 09:00:00', 'COMPLETED', 50.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(3, 8, 2, 25.00); -- 2 Lámparas (precio oferta supongamos)

INSERT INTO payments (order_id, payment_date, amount, payment_method) VALUES
(3, '2023-11-10 09:05:00', 50.00, 'DEBIT_CARD');


-- Orden 4: Carlos López compra libros
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(3, '2023-11-15 18:45:00', 'PENDING', 20.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(4, 9, 1, 20.00); -- 1 Libro

-- No payment yet for order 4
