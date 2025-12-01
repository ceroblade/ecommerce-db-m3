-- ==========================================
-- Esquema de Base de Datos E-Commerce (PostgreSQL)
-- ==========================================

-- 1. Tabla Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    direccion TEXT,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla Categorias
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 3. Tabla Productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    categoria_id INTEGER NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 0) NOT NULL CHECK (precio >= 0), -- Sin decimales
    cantidad_stock INTEGER NOT NULL DEFAULT 0 CHECK (cantidad_stock >= 0),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Indices para búsquedas frecuentes
CREATE INDEX idx_productos_nombre ON productos(nombre);
CREATE INDEX idx_productos_categoria ON productos(categoria_id);

-- 4. Tabla Ordenes (Pedidos)
CREATE TABLE ordenes (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha_orden TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'COMPLETADO', 'CANCELADO', 'ENVIADO')),
    monto_total DECIMAL(10, 0) DEFAULT 0 CHECK (monto_total >= 0), -- Sin decimales
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Índice para buscar órdenes por cliente
CREATE INDEX idx_ordenes_cliente ON ordenes(cliente_id);

-- 5. Tabla Detalles_Orden (Items de la Orden)
CREATE TABLE detalles_orden (
    id SERIAL PRIMARY KEY,
    orden_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 0) NOT NULL CHECK (precio_unitario >= 0), -- Sin decimales
    subtotal DECIMAL(10, 0) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED, -- Columna calculada
    FOREIGN KEY (orden_id) REFERENCES ordenes(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- 6. Tabla Pagos
CREATE TABLE pagos (
    id SERIAL PRIMARY KEY,
    orden_id INTEGER NOT NULL UNIQUE, -- Una orden tiene un pago principal
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 0) NOT NULL CHECK (monto > 0), -- Sin decimales
    metodo_pago VARCHAR(50) NOT NULL, -- 'TARJETA_CREDITO', 'PAYPAL', etc.
    estado VARCHAR(20) DEFAULT 'COMPLETADO',
    FOREIGN KEY (orden_id) REFERENCES ordenes(id)
);

-- 7. Tabla Movimientos_Inventario (Histórico)
CREATE TABLE movimientos_inventario (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL CHECK (tipo_movimiento IN ('ENTRADA', 'SALIDA', 'AJUSTE')),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);
