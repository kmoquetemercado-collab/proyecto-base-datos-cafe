````markdown
# 📚 INFORME ACADÉMICO - PROYECTO FINAL

## INFORMACIÓN DEL ESTUDIANTE

| Aspecto | Detalle |
|---------|---------|
| **Nombre del Estudiante** | Kimberly Moquete Mercado |
| **Matrícula** | 100573552 |
| **Asignatura** | Base de Datos I |
| **Profesor** | Eddy Leonardo Brito Polanco |
| **Fecha de Entrega** | 18 de Mayo de 2026 |
| **Institución** | Universidad Autónoma de Santo Domingo (UASD) |

---

## 📋 DESCRIPCIÓN DEL PROYECTO

### Título del Proyecto
**"Sistema de Gestión Integral para una Cafetería"**

### Objetivo General
Diseñar, modelar e implementar una base de datos relacional para una cafetería que permita gestionar de manera eficiente:
- Productos y categorías
- Clientes y sus compras
- Ventas y transacciones
- Inventario y stock

### Objetivos Específicos

1. **Análisis y Diseño**
   - Identificar las entidades principales del negocio
   - Establecer relaciones entre entidades
   - Crear modelo Entidad-Relación (ER)
   - Aplicar normalización hasta 3FN

2. **Implementación Técnica**
   - Crear estructura de tablas en SQL Server
   - Implementar restricciones de integridad
   - Establecer índices para optimización
   - Cargar datos de prueba realistas

3. **Análisis y Reportería**
   - Desarrollar consultas complejas
   - Generar reportes para la toma de decisiones
   - Crear indicadores clave de desempeño (KPIs)
   - Facilitar análisis de datos

4. **Documentación**
   - Documentar la estructura de la base de datos
   - Crear guía de instalación y uso
   - Explicar el modelo de datos
   - Proporcionar ejemplos de consultas

---

## 🏗️ ARQUITECTURA DE LA BASE DE DATOS

### 1. Modelo Conceptual

#### Entidades Identificadas

```
NEGOCIO DE CAFETERÍA
├── CLIENTES
│   └── Información personal y de contacto
├── PRODUCTOS
│   ├── Bebidas Calientes
│   ├── Bebidas Frías
│   ├── Desayunos
│   └── Almuerzos
├── CATEGORÍAS
│   └── Clasificación de productos
├── VENTAS
│   └── Transacciones realizadas
└── DETALLES_VENTAS
    └── Productos por venta
```

### 2. Diagrama Entidad-Relación (ER)

```
┌──────────────────────────────────────────────────────────────┐
│                     MODELO E-R                               │
└──────────────────────────────────────────────────────────────┘

┌─────────────────┐
│  CATEGORIAS     │
│ (1)             │
└────────┬────────┘
         │ (N)
         │ Contiene
         │
┌────────▼────────────┐
│   PRODUCTOS         │
│                     │
└────────┬────────────┘
         │ (N)
         │ Incluye
         │
         ├──────────────────────────┐
         │                          │
         │              ┌───────────────────────┐
         │              │  DETALLES_VENTAS      │
         │              │  (Tabla Asociativa)   │
         │              └───────────┬───────────┘
         │                          │ (1)
         │                          │ Parte de
         │                          │
┌────────┴─────────────────────────▼────────┐
│               VENTAS                       │
│ (Transacción Principal)                    │
└────────┬────────────────────────────────────┘
         │ (N)
         │ Realiza
         │
┌────────▼──────────┐
│   CLIENTES        │
│ (1)               │
└───────────────────┘
```

### 3. Relaciones Principales

| Relación | Tipo | Descripción |
|----------|------|-------------|
| CATEGORIAS - PRODUCTOS | 1:N | Una categoría contiene múltiples productos |
| CLIENTES - VENTAS | 1:N | Un cliente realiza múltiples ventas |
| VENTAS - DETALLES_VENTAS | 1:N | Una venta contiene múltiples detalles |
| PRODUCTOS - DETALLES_VENTAS | 1:N | Un producto aparece en múltiples ventas |

---

## 💾 ESPECIFICACIÓN TÉCNICA

### Base de Datos
- **Motor**: Microsoft SQL Server
- **Nombre**: CAFETERIA
- **Compatibilidad**: SQL Server 2016 o superior

### Tablas Implementadas

#### 1. CATEGORIAS
```sql
CREATE TABLE CATEGORIAS (
    ID_CATEGORIA INT PRIMARY KEY IDENTITY(1,1),
    NOMBRE VARCHAR(100) NOT NULL UNIQUE,
    DESCRIPCION VARCHAR(255),
    ESTADO BIT DEFAULT 1,
    FECHA_CREACION DATETIME DEFAULT GETDATE()
);
```

**Registros:** 4 categorías
- Bebidas Calientes
- Bebidas Frías
- Desayunos
- Almuerzos

#### 2. PRODUCTOS
```sql
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
```

**Registros:** 18 productos
**Rango de Precios:** $1.50 - $6.00

#### 3. CLIENTES
```sql
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
    ESTADO_CLIENTE BIT DEFAULT 1,
    FECHA_REGISTRO DATETIME DEFAULT GETDATE()
);
```

**Registros:** 8 clientes
**Ciudades Representadas:** Santo Domingo, Santiago, La Romana, Puerto Plata

#### 4. VENTAS
```sql
CREATE TABLE VENTAS (
    ID_VENTA INT PRIMARY KEY IDENTITY(1,1),
    ID_CLIENTE INT,
    FECHA_VENTA DATETIME DEFAULT GETDATE(),
    TOTAL DECIMAL(10,2) NOT NULL,
    METODO_PAGO VARCHAR(50),
    ESTADO_VENTA VARCHAR(20) DEFAULT 'Completada',
    OBSERVACIONES VARCHAR(255),
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTE)
);
```

**Registros:** 12 ventas
**Período:** 01 - 06 de Mayo de 2026
**Métodos de Pago:** Efectivo, Tarjeta

#### 5. DETALLES_VENTAS
```sql
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
```

**Registros:** 51 detalles de venta
**Promedio:** 4.25 items por venta

---

## 📊 ESTADÍSTICAS DE DATOS

### Resumen de Registros

| Tabla | Cantidad | Tipo |
|-------|----------|------|
| CATEGORIAS | 4 | Maestras |
| PRODUCTOS | 18 | Maestras |
| CLIENTES | 8 | Maestras |
| VENTAS | 12 | Transaccionales |
| DETALLES_VENTAS | 51 | Transaccionales |
| **TOTAL** | **93** | - |

### Análisis Financiero de Datos

| Métrica | Valor |
|---------|-------|
| Ingresos Totales | RD$ 130.50 |
| Número de Transacciones | 12 |
| Ticket Promedio | RD$ 10.88 |
| Venta Máxima | RD$ 18.00 |
| Venta Mínima | RD$ 6.00 |
| Clientes Activos | 8 |
| Productos Disponibles | 18 |
| Stock Total Estimado | ~620 unidades |

---

## 🔐 CARACTERÍSTICAS DE INTEGRIDAD

### Restricciones Implementadas

✅ **Claves Primarias**
- Cada tabla tiene un identificador único (ID_*)

✅ **Claves Foráneas**
- Relaciones garantizadas entre tablas
- Integridad referencial garantizada

✅ **Restricciones UNIQUE**
- EMAIL en CLIENTES (sin duplicados)
- CEDULA en CLIENTES (sin duplicados)
- NOMBRE en CATEGORIAS (sin duplicados)

✅ **Valores por Defecto**
- ESTADO = 1 (Activo)
- FECHA_CREACION = GETDATE() (Fecha actual)
- ESTADO_VENTA = 'Completada'

✅ **Tipos de Datos**
- DECIMAL(10,2) para moneda (precisión monetaria)
- DATETIME para auditoría temporal
- VARCHAR con longitud apropiada

---

## 📈 ÍNDICES PARA OPTIMIZACIÓN

```sql
CREATE INDEX IDX_PRODUCTOS_CATEGORIA ON PRODUCTOS(ID_CATEGORIA);
CREATE INDEX IDX_VENTAS_CLIENTE ON VENTAS(ID_CLIENTE);
CREATE INDEX IDX_VENTAS_FECHA ON VENTAS(FECHA_VENTA);
CREATE INDEX IDX_DETALLES_VENTA ON DETALLES_VENTAS(ID_VENTA);
CREATE INDEX IDX_DETALLES_PRODUCTO ON DETALLES_VENTAS(ID_PRODUCTO);
```

**Beneficios:**
- Consultas más rápidas en búsquedas frecuentes
- Mejor rendimiento en JOINs
- Optimización de reportes

---

## 📝 NORMALIZACIÓN

### Análisis de Normalización

#### ✅ Primera Forma Normal (1FN)
- Todos los atributos contienen valores atómicos (no divisibles)
- No hay grupos repetitivos
- Cada celda contiene un único valor

**Ejemplo:**
- NOMBRE no contiene múltiples nombres
- PRECIO es un único valor decimal
- No hay tablas de "Teléfonos Múltiples"

#### ✅ Segunda Forma Normal (2FN)
- Cumple con 1FN
- Todos los atributos no clave dependen de la clave primaria completa
- No hay dependencias parciales

**Ejemplo:**
- En PRODUCTOS: NOMBRE, PRECIO dependen de ID_PRODUCTO (no parcial)
- En DETALLES_VENTAS: Todos los atributos dependen de ID_DETALLE

#### ✅ Tercera Forma Normal (3FN)
- Cumple con 2FN
- No hay dependencias transitivas
- Cada tabla representa un concepto único

**Ejemplo:**
- CLIENTES contiene solo datos de clientes
- PRODUCTOS contiene solo datos de productos
- VENTAS solo datos de transacciones
- No hay datos redundantes entre tablas

### Justificación

La base de datos está normalizada a **3FN** porque:

1. **Elimina Redundancia**: No hay repetición de datos
2. **Integridad**: Cambios en un lugar actualizan todo
3. **Eficiencia**: Consultas más rápidas y precisas
4. **Escalabilidad**: Fácil de expandir sin problemas
5. **Mantenibilidad**: Estructura clara y organizada

---

## 🎯 CONSULTAS Y REPORTERÍA

### 12 Consultas Implementadas

| # | Consulta | Propósito |
|---|----------|----------|
| 1 | Productos Más Vendidos | Identifica productos estrella |
| 2 | Ingresos por Día | Análisis de tendencias diarias |
| 3 | Clientes Más Frecuentes | Identifica clientes VIP |
| 4 | Ventas por Categoría | Desempeño por categoría |
| 5 | Métodos de Pago | Análisis de pagos |
| 6 | Stock Actual | Control de inventario |
| 7 | Dashboard General | KPIs principales |
| 8 | Productos Sin Ventas | Análisis de bajo movimiento |
| 9 | Detalle de Ventas | Auditoría completa |
| 10 | Margen y Rentabilidad | Análisis financiero |
| 11 | Tendencias Semanales | Patrones de venta |
| 12 | Análisis de Combos | Productos vendidos juntos |

### Información para Operaciones

La base de datos permite:

✅ **Reportes de Ventas**
- Monto total por período
- Cantidad de transacciones
- Ticket promedio

✅ **Análisis de Inventario**
- Stock disponible por producto
- Productos con bajo stock
- Valor total del inventario

✅ **Análisis de Clientes**
- Clientes más frecuentes
- Patrones de compra
- Ciudades con más clientes

✅ **Análisis Financiero**
- Ingresos diarios/semanales
- Métodos de pago preferidos
- Margen de ganancia estimado

---

## 📁 ESTRUCTURA DEL PROYECTO

```
proyecto-base-datos-cafe/
│
├── 📄 01_CREACION_TABLAS.sql
│   └── Script para crear la estructura de BD
│
├── 📄 02_INSERCION_DATOS.sql
│   └── Script con datos de prueba (93 registros)
│
├── 📄 03_CONSULTAS_REPORTES.sql
│   └── 12 consultas de análisis y reportería
│
├── 📄 README.md
│   └── Documentación completa del proyecto
│
├── 📄 GUIA_INSTALACION.md
│   └── Pasos de instalación y uso
│
└── 📄 INFORME_ACADEMICO.md
    └── Este documento
```

---

## 💡 CONCEPTOS ACADÉMICOS APLICADOS

### 1. Diseño de Bases de Datos Relacionales
- ✅ Identificación de entidades
- ✅ Establecimientos de relaciones
- ✅ Atributos apropiados
- ✅ Integridad referencial

### 2. Modelo Entidad-Relación (ER)
- ✅ Diagrama conceptual
- ✅ Cardinalidades
- ✅ Atributos clave
- ✅ Entidades débiles (si aplica)

### 3. Normalización
- ✅ 1FN: Atomicidad
- ✅ 2FN: Dependencia funcional completa
- ✅ 3FN: Sin dependencias transitivas

### 4. Lenguaje SQL
- ✅ CREATE TABLE
- ✅ INSERT VALUES
- ✅ SELECT con múltiples JOINs
- ✅ Funciones de agregación
- ✅ GROUP BY y ORDER BY

### 5. Gestión de Datos
- ✅ Integridad de datos
- ✅ Consistencia transaccional
- ✅ Control de acceso
- ✅ Backup y recuperación

---

## 📊 RESULTADOS Y CONCLUSIONES

### Logros Alcanzados

✅ **Base de Datos Completamente Funcional**
- Estructura bien diseñada
- Normalizada hasta 3FN
- Integridad garantizada

✅ **Datos de Prueba Realistas**
- 93 registros en total
- Distribuidos apropiadamente
- Período coherente (Mayo 2026)

✅ **Reportería Completa**
- 12 consultas de análisis
- Cubre todos los aspectos del negocio
- Información accionable para gerentes

✅ **Documentación Profesional**
- README con explicación completa
- Guía de instalación paso a paso
- Informe académico detallado

### Conclusiones

Este proyecto demuestra comprensión de:

1. **Teoría Relacional**
   - Modelos conceptuales
   - Relaciones entre entidades
   - Cardinalidades

2. **Diseño de BD**
   - Análisis de requerimientos
   - Estructura lógica
   - Optimización con índices

3. **Implementación SQL**
   - DDL (CREATE, ALTER)
   - DML (INSERT, UPDATE)
   - DQL (SELECT con JOINs complejos)

4. **Gestión Empresarial**
   - Información relevante para decisiones
   - KPIs principales
   - Reportería gerencial

---

## 🎓 MEJORAS FUTURAS

### Posibles Extensiones

- [ ] Agregar tabla de EMPLEADOS
- [ ] Implementar RESERVAS para mesas
- [ ] Agregar PROMOCIONES y DESCUENTOS
- [ ] Sistema de PEDIDOS especiales
- [ ] Control de PROVEEDORES
- [ ] Integración con POS (Point of Sale)
- [ ] Dashboard en tiempo real
- [ ] Mobile app para clientes

---

## 📌 REFERENCIAS Y RECURSOS

### Documentación Consultada
- Microsoft SQL Server Documentation
- Fundamentos de Bases de Datos (Temáticas)
- Normalización de Bases de Datos
- SQL Query Optimization

### Herramientas Utilizadas
- SQL Server Management Studio (SSMS)
- SQL Server 2016+
- Markdown para documentación

---

## ✅ CHECKLIST DE ENTREGA

```
[✓] Base de datos creada y funcional
[✓] Tablas con estructura correcta
[✓] Datos de prueba insertados
[✓] Consultas funcionando correctamente
[✓] Documentación completa
[✓] Guía de instalación
[✓] Informe académico
[✓] Código comentado
[✓] Respaldo de archivos
[✓] Proyecto en GitHub
```

---

## 📝 INFORMACIÓN DE ENTREGA

| Aspecto | Detalle |
|---------|---------|
| **Estudiante** | Kimberly Moquete Mercado |
| **Matricula** | 100573552 |
| **Profesor** | Eddy Leonardo Brito Polanco |
| **Asignatura** | Base de Datos I |
| **Universidad** | Universidad Autónoma de Santo Domingo (UASD) |
| **Fecha de Entrega** | 18 de Mayo de 2026 |
| **Tipo de Negocio** | Cafetería |
| **Motor de BD** | Microsoft SQL Server |
| **Repositorio** | GitHub (proyecto-base-datos-cafe) |

---

## 🙏 AGRADECIMIENTOS

Agradezco al Profesor **Eddy Leonardo Brito Polanco** por la orientación en el desarrollo de este proyecto y por enseñar los conceptos fundamentales de Base de Datos que permitieron su realización.

---

## 📞 INFORMACIÓN DE CONTACTO

**Estudiante:** Kimberly Moquete Mercado  
**Matrícula:** 100573552  
**Institución:** Universidad Autónoma de Santo Domingo (UASD)  
**Período:** Mayo 2026

---

**Proyecto Final - Exitosamente Completado** ✅

*"El diseño de una buena base de datos es fundamental para el éxito de cualquier sistema de información"*

````
