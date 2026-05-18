-- ========================================
-- BASE DE DATOS: CAFETERIA
-- Descripción: Sistema de gestión para una cafetería
-- ========================================

-- Crear la base de datos
CREATE DATABASE CAFETERIA;
GO

USE CAFETERIA;
GO

-- ========================================
-- TABLA: CATEGORIAS
-- Descripción: Categorías de productos
-- ========================================
CREATE TABLE CATEGORIAS (
    ID_CATEGORIA INT PRIMARY KEY IDENTITY(1,1),
    NOMBRE VARCHAR(100) NOT NULL UNIQUE,
    DESCRIPCION VARCHAR(255),
    ESTADO BIT DEFAULT 1, -- 1 = Activo, 0 = Inactivo
    FECHA_CREACION DATETIME DEFAULT GETDATE()
);

-- ========================================
-- TABLA: PRODUCTOS
-- Descripción: Productos disponibles en la cafetería
-- ========================================
CREATE TABLE PRODUCTOS (
    ID_PRODUCTO INT PRIMARY KEY IDENTITY(1,1),
    NOMBRE VARCHAR(100) NOT NULL,
    DESCRIPCION VARCHAR(255),
    ID_CATEGORIA INT NOT NULL,
    PRECIO DECIMAL(10,2) NOT NULL,
    STOCK INT DEFAULT 0,
    ESTADO BIT DEFAULT 1,
    FECHA_CREACION DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIAS(ID_CATEGORIA)
);

-- ========================================
-- TABLA: CLIENTES
-- Descripción: Información de clientes
-- ========================================
CREATE TABLE CLIENTES (
    ID_CLIENTE INT PRIMARY KEY IDENTITY(1,1),
    NOMBRE VARCHAR(100) NOT NULL,
    APELLIDO VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(100) UNIQUE,
    TELEFONO VARCHAR(20),
    CEDULA VARCHAR(20) UNIQUE,
    FECHA_NACIMIENTO DATE,
    DIRECCION VARCHAR(255),
    CIUDAD VARCHAR(100),
    ESTADO_CLIENTE BIT DEFAULT 1, -- 1 = Activo, 0 = Inactivo
    FECHA_REGISTRO DATETIME DEFAULT GETDATE()
);

-- ========================================
-- TABLA: VENTAS
-- Descripción: Registro de ventas realizadas
-- ========================================
CREATE TABLE VENTAS (
    ID_VENTA INT PRIMARY KEY IDENTITY(1,1),
    ID_CLIENTE INT,
    FECHA_VENTA DATETIME DEFAULT GETDATE(),
    TOTAL DECIMAL(10,2) NOT NULL,
    METODO_PAGO VARCHAR(50), -- Efectivo, Tarjeta, Transferencia
    ESTADO_VENTA VARCHAR(20) DEFAULT 'Completada', -- Completada, Cancelada
    OBSERVACIONES VARCHAR(255),
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTE)
);

-- ========================================
-- TABLA: DETALLES_VENTAS
-- Descripción: Detalles de cada venta (productos vendidos)
-- ========================================
CREATE TABLE DETALLES_VENTAS (
    ID_DETALLE INT PRIMARY KEY IDENTITY(1,1),
    ID_VENTA INT NOT NULL,
    ID_PRODUCTO INT NOT NULL,
    CANTIDAD INT NOT NULL,
    PRECIO_UNITARIO DECIMAL(10,2) NOT NULL,
    SUBTOTAL DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ID_VENTA) REFERENCES VENTAS(ID_VENTA),
    FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS(ID_PRODUCTO)
);

-- ========================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ========================================
CREATE INDEX IDX_PRODUCTOS_CATEGORIA ON PRODUCTOS(ID_CATEGORIA);
CREATE INDEX IDX_VENTAS_CLIENTE ON VENTAS(ID_CLIENTE);
CREATE INDEX IDX_VENTAS_FECHA ON VENTAS(FECHA_VENTA);
CREATE INDEX IDX_DETALLES_VENTA ON DETALLES_VENTAS(ID_VENTA);
CREATE INDEX IDX_DETALLES_PRODUCTO ON DETALLES_VENTAS(ID_PRODUCTO);

-- ========================================
-- Completado: Estructura de la base de datos
-- ========================================
