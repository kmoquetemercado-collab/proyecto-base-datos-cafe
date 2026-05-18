USE CAFETERIA;
GO

-- ========================================
-- INSERCIÓN DE DATOS - CAFETERÍA
-- ========================================

-- ========================================
-- 1. INSERTAR CATEGORÍAS
-- ========================================
INSERT INTO CATEGORIAS (NOMBRE, DESCRIPCION) VALUES
('Bebidas Calientes', 'Café, Té, Chocolate caliente y otras bebidas calientes'),
('Bebidas Frías', 'Refrescos, Jugos, Batidos y bebidas frías variadas'),
('Desayunos', 'Panes, Pasteles, Sándwiches y opciones de desayuno'),
('Almuerzos', 'Platos principales y acompañamientos para almuerzo');

-- ========================================
-- 2. INSERTAR PRODUCTOS
-- ========================================

-- Bebidas Calientes (ID_CATEGORIA = 1)
INSERT INTO PRODUCTOS (NOMBRE, DESCRIPCION, ID_CATEGORIA, PRECIO, STOCK) VALUES
('Café Americano', 'Café tradicional americano recién hecho', 1, 2.50, 50),
('Café con Leche', 'Café con leche condensada dulce', 1, 3.00, 45),
('Capuchino', 'Espresso con leche espumosa y cacao', 1, 3.50, 40),
('Té Negro', 'Té negro caliente con agua filtrada', 1, 2.00, 35),
('Chocolate Caliente', 'Chocolate con leche cremoso y delicioso', 1, 3.00, 30);

-- Bebidas Frías (ID_CATEGORIA = 2)
INSERT INTO PRODUCTOS (NOMBRE, DESCRIPCION, ID_CATEGORIA, PRECIO, STOCK) VALUES
('Refresco de Naranja', 'Jugo natural de naranja recién exprimido', 2, 2.50, 60),
('Limonada', 'Limonada fresca casera con limón natural', 2, 2.00, 50),
('Batido de Fresa', 'Batido con leche y fresas frescas', 2, 3.50, 40),
('Agua Embotellada', 'Agua pura embotellada sin gas', 2, 1.50, 100),
('Batido de Plátano', 'Batido con leche y plátano natural', 2, 3.00, 35);

-- Desayunos (ID_CATEGORIA = 3)
INSERT INTO PRODUCTOS (NOMBRE, DESCRIPCION, ID_CATEGORIA, PRECIO, STOCK) VALUES
('Pan de Queso', 'Pan casero salado con queso derretido', 3, 1.50, 30),
('Croissant', 'Croissant francés hojaldrado y crujiente', 3, 2.50, 25),
('Pastel de Zanahoria', 'Pastel casero de zanahoria con frosting', 3, 2.00, 20),
('Sándwich de Jamón', 'Sándwich con jamón, queso y vegetales', 3, 3.50, 35);

-- Almuerzos (ID_CATEGORIA = 4)
INSERT INTO PRODUCTOS (NOMBRE, DESCRIPCION, ID_CATEGORIA, PRECIO, STOCK) VALUES
('Arroz con Pollo', 'Arroz blanco con pechuga de pollo jugosa', 4, 6.00, 15),
('Sopa del Día', 'Sopa casera variada con vegetales frescos', 4, 3.50, 20),
('Ensalada Mixta', 'Ensalada fresca con vegetales variados', 4, 4.00, 25),
('Sándwich Especial', 'Sándwich con carnes frías, queso y vegetales', 4, 4.50, 30);

-- ========================================
-- 3. INSERTAR CLIENTES
-- ========================================
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, CEDULA, FECHA_NACIMIENTO, DIRECCION, CIUDAD) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '809-555-1001', '12345678', '1985-03-15', 'Calle Principal 123', 'Santo Domingo'),
('María', 'García', 'maria.garcia@email.com', '809-555-1002', '87654321', '1990-07-22', 'Avenida Central 456', 'Santo Domingo'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@email.com', '809-555-1003', '11223344', '1988-05-10', 'Calle del Carmen 789', 'Santiago'),
('Ana', 'Martínez', 'ana.martinez@email.com', '809-555-1004', '44556677', '1992-11-30', 'Avenida Independencia 321', 'La Romana'),
('Pedro', 'López', 'pedro.lopez@email.com', '809-555-1005', '55667788', '1980-02-14', 'Calle Juan Pablo 654', 'Santo Domingo'),
('Laura', 'Fernández', 'laura.fernandez@email.com', '809-555-1006', '99887766', '1995-08-25', 'Avenida Las Américas 987', 'Santiago'),
('Miguel', 'Sánchez', 'miguel.sanchez@email.com', '809-555-1007', '12341234', '1987-09-05', 'Calle San Martín 147', 'Santo Domingo'),
('Sofía', 'Díaz', 'sofia.diaz@email.com', '809-555-1008', '56785678', '1993-04-18', 'Avenida Duarte 258', 'Puerto Plata');

-- ========================================
-- 4. INSERTAR VENTAS
-- ========================================
INSERT INTO VENTAS (ID_CLIENTE, FECHA_VENTA, TOTAL, METODO_PAGO, ESTADO_VENTA) VALUES
(1, '2026-05-01 08:30:00', 8.50, 'Efectivo', 'Completada'),
(2, '2026-05-01 09:15:00', 12.00, 'Tarjeta', 'Completada'),
(3, '2026-05-01 10:45:00', 15.50, 'Efectivo', 'Completada'),
(1, '2026-05-02 08:00:00', 6.00, 'Efectivo', 'Completada'),
(4, '2026-05-02 12:00:00', 10.50, 'Tarjeta', 'Completada'),
(5, '2026-05-03 07:30:00', 9.00, 'Efectivo', 'Completada'),
(2, '2026-05-03 14:00:00', 18.00, 'Efectivo', 'Completada'),
(6, '2026-05-04 08:15:00', 7.50, 'Tarjeta', 'Completada'),
(3, '2026-05-04 13:30:00', 11.00, 'Efectivo', 'Completada'),
(7, '2026-05-05 09:00:00', 14.50, 'Efectivo', 'Completada'),
(8, '2026-05-05 15:45:00', 16.00, 'Tarjeta', 'Completada'),
(1, '2026-05-06 08:45:00', 10.00, 'Efectivo', 'Completada');

-- ========================================
-- 5. INSERTAR DETALLES DE VENTAS
-- ========================================

-- VENTA 1: Total 8.50 (Juan Pérez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(1, 1, 2, 2.50, 5.00),    -- 2x Café Americano
(1, 8, 1, 3.50, 3.50);    -- 1x Batido de Fresa

-- VENTA 2: Total 12.00 (María García)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(2, 3, 1, 3.50, 3.50),    -- 1x Capuchino
(2, 12, 2, 2.50, 5.00),   -- 2x Croissant
(2, 13, 1, 3.50, 3.50);   -- 1x Pastel de Zanahoria

-- VENTA 3: Total 15.50 (Carlos Rodríguez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(3, 2, 2, 3.00, 6.00),    -- 2x Café con Leche
(3, 11, 1, 2.50, 2.50),   -- 1x Pan de Queso
(3, 15, 1, 4.00, 4.00),   -- 1x Ensalada Mixta
(3, 8, 1, 3.00, 3.00);    -- 1x Batido de Fresa (precio diferente por promoción)

-- VENTA 4: Total 6.00 (Juan Pérez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(4, 1, 2, 2.50, 5.00),    -- 2x Café Americano
(4, 9, 1, 1.50, 1.50);    -- 1x Agua Embotellada

-- VENTA 5: Total 10.50 (Ana Martínez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(5, 6, 2, 2.50, 5.00),    -- 2x Refresco de Naranja
(5, 18, 1, 4.50, 4.50),   -- 1x Sándwich Especial
(5, 9, 1, 1.50, 1.00);    -- 1x Agua Embotellada

-- VENTA 6: Total 9.00 (Pedro López)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(6, 4, 1, 2.00, 2.00),    -- 1x Té Negro
(6, 12, 2, 2.50, 5.00),   -- 2x Croissant
(6, 10, 1, 1.50, 1.50),   -- 1x Agua Embotellada
(6, 8, 1, 3.00, 3.00);    -- 1x Batido de Plátano

-- VENTA 7: Total 18.00 (María García)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(7, 3, 1, 3.50, 3.50),    -- 1x Capuchino
(7, 16, 1, 6.00, 6.00),   -- 1x Arroz con Pollo
(7, 9, 2, 1.50, 3.00),    -- 2x Agua Embotellada
(7, 8, 1, 3.00, 3.00),    -- 1x Batido de Fresa
(7, 9, 1, 1.50, 1.50);    -- 1x Agua Embotellada

-- VENTA 8: Total 7.50 (Laura Fernández)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(8, 2, 1, 3.00, 3.00),    -- 1x Café con Leche
(8, 13, 1, 3.50, 3.50),   -- 1x Pastel de Zanahoria
(8, 10, 1, 1.50, 1.50);   -- 1x Agua Embotellada

-- VENTA 9: Total 11.00 (Carlos Rodríguez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(9, 1, 2, 2.50, 5.00),    -- 2x Café Americano
(9, 17, 1, 3.50, 3.50),   -- 1x Sándwich de Jamón
(9, 9, 1, 1.50, 1.50),    -- 1x Agua Embotellada
(9, 8, 1, 3.00, 3.00);    -- 1x Batido de Fresa

-- VENTA 10: Total 14.50 (Miguel Sánchez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(10, 5, 1, 3.00, 3.00),   -- 1x Chocolate Caliente
(10, 14, 1, 2.00, 2.00),  -- 1x Sopa del Día
(10, 18, 1, 4.50, 4.50),  -- 1x Sándwich Especial
(10, 9, 2, 1.50, 3.00),   -- 2x Agua Embotellada
(10, 9, 1, 1.50, 1.50);   -- 1x Agua Embotellada

-- VENTA 11: Total 16.00 (Sofía Díaz)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(11, 3, 1, 3.50, 3.50),   -- 1x Capuchino
(11, 16, 1, 6.00, 6.00),  -- 1x Arroz con Pollo
(11, 9, 2, 1.50, 3.00),   -- 2x Agua Embotellada
(11, 8, 1, 3.00, 3.00);   -- 1x Batido de Fresa

-- VENTA 12: Total 10.00 (Juan Pérez)
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL) VALUES
(12, 1, 2, 2.50, 5.00),   -- 2x Café Americano
(12, 12, 1, 2.50, 2.50),  -- 1x Croissant
(12, 10, 1, 1.50, 1.50);  -- 1x Agua Embotellada

-- ========================================
-- CONFIRMACIÓN DE INSERCIÓN
-- ========================================
PRINT '✓ Categorías insertadas: 4';
PRINT '✓ Productos insertados: 18';
PRINT '✓ Clientes insertados: 8';
PRINT '✓ Ventas insertadas: 12';
PRINT '✓ Detalles de venta insertados: 51';
PRINT '';
PRINT 'Datos de prueba cargados exitosamente.';

-- ========================================
-- VERIFICACIÓN (Opcional - Para validar)
-- ========================================
-- SELECT 'Categorías' AS Tabla, COUNT(*) AS Total FROM CATEGORIAS
-- UNION ALL
-- SELECT 'Productos', COUNT(*) FROM PRODUCTOS
-- UNION ALL
-- SELECT 'Clientes', COUNT(*) FROM CLIENTES
-- UNION ALL
-- SELECT 'Ventas', COUNT(*) FROM VENTAS
-- UNION ALL
-- SELECT 'Detalles Ventas', COUNT(*) FROM DETALLES_VENTAS;
