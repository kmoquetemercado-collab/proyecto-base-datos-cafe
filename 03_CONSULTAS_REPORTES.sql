USE CAFETERIA;
GO

-- ========================================
-- CONSULTAS Y REPORTES - CAFETERÍA
-- Sistema de consultas para análisis de negocio
-- ========================================

-- ========================================
-- CONSULTA 1: PRODUCTOS MÁS VENDIDOS
-- Descripción: Identifica los productos con mayor demanda
-- Uso: Gestión de inventario y estrategia de compras
-- ========================================
PRINT '========================================';
PRINT 'CONSULTA 1: PRODUCTOS MÁS VENDIDOS';
PRINT '========================================';
GO

SELECT TOP 10
    p.ID_PRODUCTO,
    p.NOMBRE AS 'Producto',
    c.NOMBRE AS 'Categoría',
    SUM(dv.CANTIDAD) AS 'Total Vendido',
    p.PRECIO AS 'Precio Unitario',
    SUM(dv.SUBTOTAL) AS 'Ingresos Totales',
    ROUND(SUM(dv.SUBTOTAL) * 100.0 / (SELECT SUM(SUBTOTAL) FROM DETALLES_VENTAS), 2) AS 'Porcentaje (%)'
FROM DETALLES_VENTAS dv
INNER JOIN PRODUCTOS p ON dv.ID_PRODUCTO = p.ID_PRODUCTO
INNER JOIN CATEGORIAS c ON p.ID_CATEGORIA = c.ID_CATEGORIA
GROUP BY p.ID_PRODUCTO, p.NOMBRE, c.NOMBRE, p.PRECIO
ORDER BY [Total Vendido] DESC;

-- ========================================
-- CONSULTA 2: INGRESOS POR DÍA
-- Descripción: Análisis diario de ventas y estadísticas
-- Uso: Control financiero y tendencias de venta
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 2: INGRESOS POR DÍA';
PRINT '========================================';
GO

SELECT
    CAST(FECHA_VENTA AS DATE) AS 'Fecha',
    COUNT(*) AS 'Total Ventas',
    SUM(TOTAL) AS 'Ingresos Diarios',
    ROUND(AVG(TOTAL), 2) AS 'Ticket Promedio',
    MAX(TOTAL) AS 'Venta Máxima',
    MIN(TOTAL) AS 'Venta Mínima'
FROM VENTAS
WHERE ESTADO_VENTA = 'Completada'
GROUP BY CAST(FECHA_VENTA AS DATE)
ORDER BY CAST(FECHA_VENTA AS DATE) DESC;

-- ========================================
-- CONSULTA 3: CLIENTES MÁS FRECUENTES
-- Descripción: Identifica clientes con mayor actividad de compra
-- Uso: Programas de fidelización y marketing directo
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 3: CLIENTES MÁS FRECUENTES';
PRINT '========================================';
GO

SELECT TOP 10
    c.ID_CLIENTE,
    c.NOMBRE + ' ' + c.APELLIDO AS 'Cliente',
    c.EMAIL AS 'Email',
    c.CIUDAD AS 'Ciudad',
    COUNT(v.ID_VENTA) AS 'Total Compras',
    SUM(v.TOTAL) AS 'Gasto Total',
    ROUND(AVG(v.TOTAL), 2) AS 'Ticket Promedio',
    MAX(v.FECHA_VENTA) AS 'Última Compra'
FROM CLIENTES c
LEFT JOIN VENTAS v ON c.ID_CLIENTE = v.ID_CLIENTE
GROUP BY c.ID_CLIENTE, c.NOMBRE, c.APELLIDO, c.EMAIL, c.CIUDAD
ORDER BY [Total Compras] DESC;

-- ========================================
-- CONSULTA 4: VENTAS POR CATEGORÍA
-- Descripción: Análisis de desempeño por categoría de producto
-- Uso: Decisiones de inversión en stock y promociones
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 4: VENTAS POR CATEGORÍA';
PRINT '========================================';
GO

SELECT
    c.ID_CATEGORIA,
    c.NOMBRE AS 'Categoría',
    c.DESCRIPCION AS 'Descripción',
    COUNT(dv.ID_DETALLE) AS 'Productos Vendidos',
    SUM(dv.CANTIDAD) AS 'Cantidad Total',
    SUM(dv.SUBTOTAL) AS 'Ingresos Categoría',
    ROUND(SUM(dv.SUBTOTAL) * 100.0 / (SELECT SUM(SUBTOTAL) FROM DETALLES_VENTAS), 2) AS 'Porcentaje (%)',
    ROUND(AVG(dv.SUBTOTAL), 2) AS 'Venta Promedio'
FROM CATEGORIAS c
LEFT JOIN PRODUCTOS p ON c.ID_CATEGORIA = p.ID_CATEGORIA
LEFT JOIN DETALLES_VENTAS dv ON p.ID_PRODUCTO = dv.ID_PRODUCTO
GROUP BY c.ID_CATEGORIA, c.NOMBRE, c.DESCRIPCION
ORDER BY [Ingresos Categoría] DESC;

-- ========================================
-- CONSULTA 5: MÉTODOS DE PAGO UTILIZADOS
-- Descripción: Análisis de métodos de pago preferidos
-- Uso: Decisiones sobre sistemas de pago y facilidades
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 5: MÉTODOS DE PAGO UTILIZADOS';
PRINT '========================================';
GO

SELECT
    METODO_PAGO AS 'Método de Pago',
    COUNT(*) AS 'Total Transacciones',
    SUM(TOTAL) AS 'Total Ingresos',
    ROUND(AVG(TOTAL), 2) AS 'Ticket Promedio',
    ROUND(SUM(TOTAL) * 100.0 / (SELECT SUM(TOTAL) FROM VENTAS WHERE ESTADO_VENTA = 'Completada'), 2) AS 'Porcentaje (%)'
FROM VENTAS
WHERE ESTADO_VENTA = 'Completada'
GROUP BY METODO_PAGO
ORDER BY [Total Ingresos] DESC;

-- ========================================
-- CONSULTA 6: STOCK ACTUAL DE PRODUCTOS
-- Descripción: Control de inventario disponible
-- Uso: Gestión de reorden y control de almacén
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 6: STOCK ACTUAL DE PRODUCTOS';
PRINT '========================================';
GO

SELECT
    p.ID_PRODUCTO,
    p.NOMBRE AS 'Producto',
    c.NOMBRE AS 'Categoría',
    p.STOCK AS 'Stock Actual',
    p.PRECIO AS 'Precio Unitario',
    (p.STOCK * p.PRECIO) AS 'Valor Inventario',
    CASE 
        WHEN p.STOCK < 10 THEN 'CRÍTICO'
        WHEN p.STOCK < 20 THEN 'BAJO'
        WHEN p.STOCK < 50 THEN 'NORMAL'
        ELSE 'ALTO'
    END AS 'Estado Stock'
FROM PRODUCTOS p
INNER JOIN CATEGORIAS c ON p.ID_CATEGORIA = c.ID_CATEGORIA
WHERE p.ESTADO = 1
ORDER BY p.STOCK ASC;

-- ========================================
-- CONSULTA 7: RESUMEN GENERAL (DASHBOARD)
-- Descripción: Indicadores clave del negocio
-- Uso: Vista ejecutiva de la operación
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 7: RESUMEN GENERAL (DASHBOARD)';
PRINT '========================================';
GO

SELECT
    (SELECT COUNT(*) FROM CLIENTES WHERE ESTADO_CLIENTE = 1) AS 'Total Clientes Activos',
    (SELECT COUNT(*) FROM VENTAS WHERE ESTADO_VENTA = 'Completada') AS 'Total Ventas Completadas',
    (SELECT SUM(TOTAL) FROM VENTAS WHERE ESTADO_VENTA = 'Completada') AS 'Ingresos Totales',
    (SELECT ROUND(AVG(TOTAL), 2) FROM VENTAS WHERE ESTADO_VENTA = 'Completada') AS 'Ticket Promedio',
    (SELECT COUNT(DISTINCT ID_CLIENTE) FROM VENTAS) AS 'Clientes con Compras',
    (SELECT SUM(STOCK * PRECIO) FROM PRODUCTOS WHERE ESTADO = 1) AS 'Valor Total Inventario',
    (SELECT COUNT(*) FROM PRODUCTOS WHERE STOCK < 20 AND ESTADO = 1) AS 'Productos con Stock Bajo';

-- ========================================
-- CONSULTA 8: PRODUCTOS SIN VENTAS
-- Descripción: Identifica productos con bajo movimiento
-- Uso: Decisiones sobre mantener o discontinuar productos
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 8: PRODUCTOS SIN VENTAS';
PRINT '========================================';
GO

SELECT
    p.ID_PRODUCTO,
    p.NOMBRE AS 'Producto',
    c.NOMBRE AS 'Categoría',
    p.PRECIO AS 'Precio',
    p.STOCK AS 'Stock Actual',
    p.FECHA_CREACION AS 'Fecha de Creación'
FROM PRODUCTOS p
INNER JOIN CATEGORIAS c ON p.ID_CATEGORIA = c.ID_CATEGORIA
WHERE p.ID_PRODUCTO NOT IN (
    SELECT DISTINCT ID_PRODUCTO FROM DETALLES_VENTAS
)
AND p.ESTADO = 1
ORDER BY p.FECHA_CREACION DESC;

-- ========================================
-- CONSULTA 9: DETALLE COMPLETO DE VENTAS
-- Descripción: Información detallada de cada transacción
-- Uso: Auditoría y análisis transaccional
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 9: DETALLE COMPLETO DE VENTAS';
PRINT '========================================';
GO

SELECT
    v.ID_VENTA AS 'ID Venta',
    CAST(v.FECHA_VENTA AS DATE) AS 'Fecha',
    DATENAME(WEEKDAY, v.FECHA_VENTA) AS 'Día Semana',
    FORMAT(v.FECHA_VENTA, 'HH:mm') AS 'Hora',
    c.NOMBRE + ' ' + c.APELLIDO AS 'Cliente',
    p.NOMBRE AS 'Producto',
    dv.CANTIDAD AS 'Cantidad',
    dv.PRECIO_UNITARIO AS 'Precio Unit.',
    dv.SUBTOTAL AS 'Subtotal',
    v.METODO_PAGO AS 'Método Pago',
    v.TOTAL AS 'Total Venta'
FROM VENTAS v
INNER JOIN CLIENTES c ON v.ID_CLIENTE = c.ID_CLIENTE
INNER JOIN DETALLES_VENTAS dv ON v.ID_VENTA = dv.ID_VENTA
INNER JOIN PRODUCTOS p ON dv.ID_PRODUCTO = p.ID_PRODUCTO
WHERE v.ESTADO_VENTA = 'Completada'
ORDER BY v.FECHA_VENTA DESC, v.ID_VENTA DESC;

-- ========================================
-- CONSULTA 10: ANÁLISIS DE MARGEN Y RENTABILIDAD
-- Descripción: Estimación de margen por producto (Asumiendo 30% de costo)
-- Uso: Análisis de rentabilidad y decisiones de pricing
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 10: ANÁLISIS DE MARGEN Y RENTABILIDAD';
PRINT '========================================';
GO

SELECT TOP 15
    p.ID_PRODUCTO,
    p.NOMBRE AS 'Producto',
    c.NOMBRE AS 'Categoría',
    p.PRECIO AS 'Precio Venta',
    ROUND(p.PRECIO * 0.30, 2) AS 'Costo Estimado (30%)',
    ROUND(p.PRECIO * 0.70, 2) AS 'Margen Estimado',
    ROUND((0.70 * 100), 2) AS 'Margen %',
    SUM(dv.CANTIDAD) AS 'Unidades Vendidas',
    ROUND(SUM(dv.SUBTOTAL) * 0.70, 2) AS 'Ganancia Estimada'
FROM PRODUCTOS p
INNER JOIN CATEGORIAS c ON p.ID_CATEGORIA = c.ID_CATEGORIA
LEFT JOIN DETALLES_VENTAS dv ON p.ID_PRODUCTO = dv.ID_PRODUCTO
WHERE p.ESTADO = 1
GROUP BY p.ID_PRODUCTO, p.NOMBRE, c.NOMBRE, p.PRECIO
ORDER BY [Ganancia Estimada] DESC;

-- ========================================
-- CONSULTA 11: ANÁLISIS DE TENDENCIAS SEMANALES
-- Descripción: Comportamiento de ventas por día de semana
-- Uso: Planificación de personal y promociones
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 11: ANÁLISIS DE TENDENCIAS SEMANALES';
PRINT '========================================';
GO

SELECT
    DATENAME(WEEKDAY, v.FECHA_VENTA) AS 'Día de Semana',
    COUNT(*) AS 'Total Ventas',
    SUM(v.TOTAL) AS 'Ingresos',
    ROUND(AVG(v.TOTAL), 2) AS 'Ticket Promedio',
    MAX(v.TOTAL) AS 'Venta Mayor'
FROM VENTAS v
WHERE v.ESTADO_VENTA = 'Completada'
GROUP BY DATENAME(WEEKDAY, v.FECHA_VENTA)
ORDER BY MIN(DATEPART(WEEKDAY, v.FECHA_VENTA));

-- ========================================
-- CONSULTA 12: ANÁLISIS DE COMBOS VENDIDOS
-- Descripción: Productos más comprados juntos
-- Uso: Oportunidades de venta cruzada y combos
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'CONSULTA 12: ANÁLISIS DE COMBOS VENDIDOS';
PRINT '========================================';
GO

SELECT TOP 10
    STRING_AGG(p.NOMBRE, ' + ') AS 'Combinación de Productos',
    COUNT(DISTINCT v.ID_VENTA) AS 'Veces Comprados Juntos',
    ROUND(AVG(v.TOTAL), 2) AS 'Ticket Promedio'
FROM VENTAS v
INNER JOIN DETALLES_VENTAS dv ON v.ID_VENTA = dv.ID_VENTA
INNER JOIN PRODUCTOS p ON dv.ID_PRODUCTO = p.ID_PRODUCTO
WHERE v.ESTADO_VENTA = 'Completada'
GROUP BY v.ID_VENTA
HAVING COUNT(DISTINCT dv.ID_PRODUCTO) > 1
ORDER BY COUNT(DISTINCT v.ID_VENTA) DESC;

-- ========================================
-- FIN DE CONSULTAS Y REPORTES
-- ========================================
PRINT '';
PRINT '========================================';
PRINT 'TODAS LAS CONSULTAS EJECUTADAS';
PRINT '========================================';
