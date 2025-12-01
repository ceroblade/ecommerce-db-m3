# Proyecto de Base de Datos E-Commerce (M3)

Este proyecto implementa el modelo de base de datos para una plataforma de e-commerce simplificada. Incluye el diseño del esquema, datos de prueba y consultas analíticas clave.

## Estructura del Proyecto

```
ecommerce-db-m3/
├── docs/
│   └── er.png          # Diagrama Entidad-Relación (ER)
├── sql/
│   ├── schema.sql      # Script DDL para crear tablas y restricciones
│   ├── seed.sql        # Script para poblar la BD con datos de prueba
│   └── queries.sql     # Consultas de negocio y transacciones ejemplo
├── data/               # Archivos CSV con datos de prueba
└── README.md           # Documentación del proyecto
```

## Modelo de Datos

El modelo incluye las siguientes entidades principales:
*   **Clientes**: Información de los usuarios registrados.
*   **Productos y Categorias**: Catálogo de productos organizado jerárquicamente.
*   **Ordenes y Detalles_Orden**: Registro de transacciones de venta y su detalle.
*   **Pagos**: Registro de pagos asociados a las órdenes.
*   **Movimientos_Inventario**: (Opcional) Historial de movimientos de stock.

Puedes ver el diagrama completo en `docs/er.png` (Nota: El diagrama puede mantener nombres en inglés si no ha sido regenerado).

## Instrucciones de Uso

### 1. Crear la Base de Datos
Ejecuta el script `schema.sql` en tu cliente de PostgreSQL o MySQL (adaptando los tipos si es necesario, este script está optimizado para PostgreSQL).

```sql
\i sql/schema.sql
```

### 2. Cargar Datos de Prueba
Puebla la base de datos con información inicial para realizar pruebas.

```sql
\i sql/seed.sql
```

### 3. Ejecutar Consultas
El archivo `queries.sql` contiene ejemplos de:
*   Búsqueda de productos.
*   Reportes de ventas (Top productos, ventas por mes).
*   Gestión de inventario (Stock bajo).
*   Análisis de clientes.
*   **Transacción Completa**: Un bloque `BEGIN...COMMIT` que simula el proceso de compra completo (crear orden, ítems y descontar stock).

## Requisitos Cumplidos
*   [x] Diagrama ER exportado.
*   [x] Schema DDL con PK, FK, UNIQUE, CHECK e Índices.
*   [x] Seed data suficiente para pruebas.
*   [x] Más de 5 consultas SQL complejas (JOINs, Agregaciones).
*   [x] Transacción ACID implementada.
