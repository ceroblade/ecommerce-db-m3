-- Datos de Prueba (Seed Data)

-- Insertar Categorias
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Dispositivos electrónicos, gadgets y accesorios.'),
('Ropa', 'Vestimenta para hombres, mujeres y niños.'),
('Hogar', 'Artículos para la decoración y uso en el hogar.'),
('Libros', 'Libros físicos y digitales de diversos géneros.');

-- Insertar Productos
-- Electrónica
INSERT INTO productos (categoria_id, nombre, precio, cantidad_stock) VALUES
(1, 'Smartphone X', 700, 50),
(1, 'Laptop Pro', 1300, 30),
(1, 'Auriculares Bluetooth', 60, 100);

-- Ropa
INSERT INTO productos (categoria_id, nombre, precio, cantidad_stock) VALUES
(2, 'Camiseta Básica', 15, 200),
(2, 'Jeans Clásicos', 45, 150),
(2, 'Zapatillas Deportivas', 90, 80);

-- Hogar
INSERT INTO productos (categoria_id, nombre, precio, cantidad_stock) VALUES
(3, 'Lámpara de Escritorio', 26, 60),
(3, 'Juego de Sábanas', 35, 40);

-- Libros
INSERT INTO productos (categoria_id, nombre, precio, cantidad_stock) VALUES
(4, 'El Señor de los Anillos', 20, 10), -- Stock bajo intencional
(4, 'Aprende SQL en 10 días', 30, 5);  -- Stock bajo intencional

-- Producto sin ventas (para probar consulta)
INSERT INTO productos (categoria_id, nombre, precio, cantidad_stock) VALUES
(1, 'Tablet Antigua', 150, 10);

-- Insertar Clientes
INSERT INTO clientes (nombre, apellido, correo, direccion) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', 'Av. Siempre Viva 123'),
('María', 'Gómez', 'maria.gomez@email.com', 'Calle Falsa 456'),
('Carlos', 'López', 'carlos.lopez@email.com', 'Boulevard Central 789'),
('Ana', 'Martínez', 'ana.martinez@email.com', 'Plaza Mayor 101');

-- Insertar Ordenes y Detalles (Histórico)

-- Orden 1: Juan Pérez compra electrónica
INSERT INTO ordenes (cliente_id, fecha_orden, estado, monto_total) VALUES
(1, '2023-10-01 10:00:00', 'COMPLETADO', 760);

INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 700), -- 1 Smartphone
(1, 3, 1, 60);  -- 1 Auriculares

INSERT INTO pagos (orden_id, fecha_pago, monto, metodo_pago) VALUES
(1, '2023-10-01 10:05:00', 760, 'TARJETA_CREDITO');


-- Orden 2: María Gómez compra ropa
INSERT INTO ordenes (cliente_id, fecha_orden, estado, monto_total) VALUES
(2, '2023-10-05 15:30:00', 'ENVIADO', 105);

INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario) VALUES
(2, 2, 1, 15),  -- 1 Camiseta
(2, 6, 1, 90);  -- 1 Zapatillas

INSERT INTO pagos (orden_id, fecha_pago, monto, metodo_pago) VALUES
(2, '2023-10-05 15:35:00', 105, 'PAYPAL');


-- Orden 3: Juan Pérez compra más cosas (Cliente frecuente)
INSERT INTO ordenes (cliente_id, fecha_orden, estado, monto_total) VALUES
(1, '2023-11-10 09:00:00', 'COMPLETADO', 50);

INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario) VALUES
(3, 8, 2, 25); -- 2 Lámparas (precio oferta supongamos)

INSERT INTO pagos (orden_id, fecha_pago, monto, metodo_pago) VALUES
(3, '2023-11-10 09:05:00', 50, 'TARJETA_DEBITO');


-- Orden 4: Carlos López compra libros
INSERT INTO ordenes (cliente_id, fecha_orden, estado, monto_total) VALUES
(3, '2023-11-15 18:45:00', 'PENDIENTE', 20);

INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario) VALUES
(4, 9, 1, 20); -- 1 Libro

-- No hay pago aún para la orden 4
