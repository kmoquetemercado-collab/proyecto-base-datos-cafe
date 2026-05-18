````markdown
# 📊 BASE DE DATOS - CAFETERÍA

## 📋 Descripción del Proyecto

Sistema de gestión integral para una cafetería que permite administrar:
- **Productos**: Bebidas y alimentos disponibles
- **Categorías**: Clasificación de productos
- **Clientes**: Información de clientes registrados
- **Ventas**: Registro de transacciones realizadas
- **Detalles de Ventas**: Productos vendidos en cada transacción

---

## 🏗️ Estructura de la Base de Datos

### Diagrama Entidad-Relación (ER)

```
┌──────────────┐
│ CATEGORIAS   │
│ (1)          │
└──────┬───────┘
       │ (N)
       │
┌──────▼──────────┐
│   PRODUCTOS     │
│                 │
└────────────────┘
       │
       │ (N)
       │
       ├──────────────────────────┐
       │                          │
┌──────��──────────┐      ┌─────────────────────┐
│ DETALLES_VENTAS │      │      VENTAS         │
└─────────────────┘      │ (1)                 │
       │                 └──────┬──────────────┘
       └─────────────────────────┤ (N)
                                 │
                          ┌──────▼────────┐
                          │    CLIENTES    │
                          │ (1)            │
                          └────────────────┘
```

---

## 📌 Tablas Principales

### 1. **CATEGORIAS**
Clasificación de productos disponibles

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID_CATEGORIA | INT PK | Identificador único |
| NOMBRE | VARCHAR(100) | Nombre de la categoría |
| DESCRIPCION | VARCHAR(255) | Descripción breve |
| ESTADO | BIT | 1=Activo, 0=Inactivo |
| FECHA_CREACION | DATETIME | Fecha de creación |

**Categorías incluidas:**
- ☕ Bebidas Calientes
- 🧊 Bebidas Frías
- 🥐 Desayunos
- 🍽️ Almuerzos

---

### 2. **PRODUCTOS**
Artículos disponibles en la cafetería

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID_PRODUCTO | INT PK | Identificador único |
| NOMBRE | VARCHAR(100) | Nombre del producto |
| DESCRIPCION | VARCHAR(255) | Descripción del producto |
| ID_CATEGORIA | INT FK | Categoría a la que pertenece |
| PRECIO | DECIMAL(10,2) | Precio unitario |
| STOCK | INT | Cantidad disponible |
| ESTADO | BIT | 1=Activo, 0=Inactivo |
| FECHA_CREACION | DATETIME | Fecha de creación |

**Total: 18 Productos**

**Ejemplos de Productos:**
- Café Americano - $2.50
- Capuchino - $3.50
- Sándwich de Jamón - $3.50
- Arroz con Pollo - $6.00
- Batido de Fresa - $3.50

---

### 3. **CLIENTES**
Información de clientes registrados

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID_CLIENTE | INT PK | Identificador único |
| NOMBRE | VARCHAR(100) | Nombre del cliente |
| APELLIDO | VARCHAR(100) | Apellido del cliente |
| EMAIL | VARCHAR(100) | Correo electrónico (único) |
| TELEFONO | VARCHAR(20) | Teléfono de contacto |
| CEDULA | VARCHAR(20) | Número de cédula (único) |
| FECHA_NACIMIENTO | DATE | Fecha de nacimiento |
| DIRECCION | VARCHAR(255) | Dirección |
| CIUDAD | VARCHAR(100) | Ciudad |
| ESTADO_CLIENTE | BIT | 1=Activo, 0=Inactivo |
| FECHA_REGISTRO | DATETIME | Fecha de registro |

**Total: 8 Clientes registrados**

---

### 4. **VENTAS**
Registro de transacciones realizadas

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID_VENTA | INT PK | Identificador único |
| ID_CLIENTE | INT FK | Cliente que realizó la compra |
| FECHA_VENTA | DATETIME | Fecha y hora de la venta |
| TOTAL | DECIMAL(10,2) | Monto total de la venta |
| METODO_PAGO | VARCHAR(50) | Efectivo, Tarjeta, Transferencia |
| ESTADO_VENTA | VARCHAR(20) | Completada, Cancelada |
| OBSERVACIONES | VARCHAR(255) | Notas adicionales |

**Total: 12 Ventas registradas**

---

### 5. **DETALLES_VENTAS**
Productos incluidos en cada venta

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID_DETALLE | INT PK | Identificador único |
| ID_VENTA | INT FK | Venta a la que pertenece |
| ID_PRODUCTO | INT FK | Producto vendido |
| CANTIDAD | INT | Cantidad vendida |
| PRECIO_UNITARIO | DECIMAL(10,2) | Precio al momento de la venta |
| SUBTOTAL | DECIMAL(10,2) | Cantidad × Precio |

**Total: 51 Detalles de venta**

---

## 📊 Consultas Principales Disponibles

### 1. **Productos Más Vendidos**
Identifica qué productos tienen mayor demanda y generan más ingresos.
```sql
-- Resultado esperado: Café Americano y Agua Embotellada como líderes
```

### 2. **Ingresos por Día**
Muestra el rendimiento diario del negocio con estadísticas completas.
```sql
-- Período: 01-06 de Mayo de 2026
-- Ingresos totales esperados: ~130.50 RD$
```

### 3. **Clientes Más Frecuentes**
Identifica los clientes que más compran y su gasto total.
```sql
-- Clientes frecuentes: Juan Pérez, María García, Carlos Rodríguez
```

### 4. **Ventas por Categoría**
Analiza qué categoría genera más ingresos.
```sql
-- Categoría de mayor venta: Bebidas Calientes y Almuerzos
```

### 5. **Métodos de Pago**
Registra las formas de pago utilizadas y su proporción.
```sql
-- Métodos: Efectivo (60%), Tarjeta (40%)
```

### 6. **Stock Actual**
Control de inventario disponible con nivel de reorden.
```sql
-- Alerta: Productos con stock < 10 marcados como CRÍTICOS
```

### 7. **Dashboard General**
Resumen ejecutivo de la operación completa.
```sql
-- KPIs principales en una sola consulta
```

### 8. **Productos Sin Ventas**
Identifica productos que aún no han sido vendidos.

### 9. **Detalle Completo de Ventas**
Información detallada de cada venta con día de la semana.

### 10. **Análisis de Margen**
Calcula margen de ganancia estimado por producto.

---

## 🔑 Restricciones de Integridad

- ✅ **Clave Primaria**: Todas las tablas tienen ID único
- ✅ **Clave Foránea**: Relaciones entre tablas garantizan integridad referencial
- ✅ **Unicidad**: Email y Cédula en CLIENTES, Nombre en CATEGORIAS
- ✅ **Valores por Defecto**: Estado (1), Fecha (Actual)
- ✅ **Tipos de Datos**: DECIMAL para moneda, DATETIME para fechas

---

## 📈 Índices para Optimización

```sql
CREATE INDEX IDX_PRODUCTOS_CATEGORIA ON PRODUCTOS(ID_CATEGORIA);
CREATE INDEX IDX_VENTAS_CLIENTE ON VENTAS(ID_CLIENTE);
CREATE INDEX IDX_VENTAS_FECHA ON VENTAS(FECHA_VENTA);
CREATE INDEX IDX_DETALLES_VENTA ON DETALLES_VENTAS(ID_VENTA);
CREATE INDEX IDX_DETALLES_PRODUCTO ON DETALLES_VENTAS(ID_PRODUCTO);
```

**Beneficios:**
- Consultas más rápidas
- Mejor rendimiento en búsquedas
- Optimización de reportes

---

## 💾 Datos de Prueba Incluidos

| Recurso | Cantidad | Período |
|---------|----------|---------|
| Clientes | 8 | Diferentes ciudades |
| Productos | 18 | Distribuidos en 4 categorías |
| Ventas | 12 | 01-06 de Mayo de 2026 |
| Detalles de Venta | 51 | Promedio 4.25 items por venta |

**Total de Ingresos en Período de Prueba:** ~130.50 RD$

---

## 🎯 Información Relevante para Operaciones

La base de datos permite generar:

### 📈 Reportes Operacionales
1. **Reporte de Ventas Diarias**: Monto total, cantidad de transacciones, ticket promedio
2. **Análisis de Productos**: Cuáles venden más, cuáles tienen bajo stock, margen de ganancia
3. **Comportamiento del Cliente**: Clientes frecuentes, gasto promedio, últimas compras
4. **Control de Inventario**: Stock disponible, valor en almacén, productos críticos
5. **Análisis Financiero**: Ingresos diarios, métodos de pago, tendencias

### 💡 Toma de Decisiones
- **Gestión de Inventario**: Identificar productos con bajo stock
- **Estrategia Comercial**: Conocer productos estrella vs lentos
- **Marketing**: Identificar clientes frecuentes para programas de fidelización
- **Finanzas**: Proyectar ingresos, analizar métodos de pago preferidos
- **Operaciones**: Conocer horarios de mayor venta

---

## 📝 Normalización

La base de datos está normalizada hasta **3FN** (Tercera Forma Normal):

### ✅ Primera Forma Normal (1FN)
- Todos los atributos contienen valores atómicos (indivisibles)
- No hay grupos repetitivos
- Cada atributo almacena un único valor

### ✅ Segunda Forma Normal (2FN)
- Cumple con 1FN
- Todos los atributos no clave dependen completamente de la clave primaria
- No hay dependencias parciales

### ✅ Tercera Forma Normal (3FN)
- Cumple con 2FN
- No hay dependencias transitivas entre atributos no clave
- Cada tabla representa un concepto único

---

## 🚀 Cómo Usar

### Paso 1: Crear la Base de Datos
```bash
# Ejecutar en SQL Server Management Studio
01_CREACION_TABLAS.sql
```

### Paso 2: Cargar Datos de Prueba
```bash
# Ejecutar el script de inserción
02_INSERCION_DATOS.sql
```

### Paso 3: Ejecutar Reportes
```bash
# Ejecutar cualquiera de las 10 consultas
03_CONSULTAS_REPORTES.sql
```

---

## 📁 Estructura del Proyecto

```
proyecto-base-datos-cafe/
├── 01_CREACION_TABLAS.sql
├── 02_INSERCION_DATOS.sql
├── 03_CONSULTAS_REPORTES.sql
└── README.md
```

---

## 📊 Diagrama de Flujo de Datos

```
CLIENTE
   │
   ├─► REALIZAR COMPRA
   │        │
   │        └─► VENTA (Genera)
   │              │
   │              └─► DETALLES_VENTA
   │                    │
   │                    └─► PRODUCTOS (Desde)
   │                         │
   │                         └─► CATEGORIAS
   │
   └─► INFORMACIÓN REGISTRADA EN CLIENTES
```

---

## 🔐 Características de Seguridad

- ✅ Validación mediante claves foráneas
- ✅ Estados booleanos para control de registros activos
- ✅ Campos únicos para evitar duplicados (EMAIL, CEDULA)
- ✅ Timestamps automáticos (FECHA_CREACION)
- ✅ Auditoría de transacciones (FECHA_VENTA, METODO_PAGO)

---

## 💬 Consultas de Ejemplo

### ¿Cuál es el producto más vendido?
```sql
SELECT TOP 1 p.NOMBRE, SUM(dv.CANTIDAD) as Total
FROM DETALLES_VENTAS dv
JOIN PRODUCTOS p ON dv.ID_PRODUCTO = p.ID_PRODUCTO
GROUP BY p.NOMBRE
ORDER BY Total DESC;
```

### ¿Cuáles son los ingresos totales?
```sql
SELECT SUM(TOTAL) as "Ingresos Totales"
FROM VENTAS
WHERE ESTADO_VENTA = 'Completada';
```

### ¿Quién es el cliente más frecuente?
```sql
SELECT TOP 1 c.NOMBRE, COUNT(*) as "Total Compras"
FROM VENTAS v
JOIN CLIENTES c ON v.ID_CLIENTE = c.ID_CLIENTE
GROUP BY c.NOMBRE
ORDER BY COUNT(*) DESC;
```

---

## 📝 Metadata del Proyecto

| Aspecto | Detalle |
|--------|---------|
| Base de Datos | CAFETERIA |
| Tablas | 5 |
| Relaciones | 4 |
| Registros Total | ~95 |
| Período de Datos | Mayo 2026 |
| Motor | SQL Server |
| Normalización | 3FN |
| Índices | 5 |

---

## 👨‍💼 Información de Entrega

**Estudiante:** [Ingresa tu nombre]  
**Materia:** Base de Datos I  
**Profesor:** [Ingresa el nombre del profesor]  
**Fecha de Entrega:** Mayo 2026  
**Tipo de Negocio:** Cafetería  

---

## 📚 Archivos Adjuntos

1. ✅ `01_CREACION_TABLAS.sql` - Script para crear la estructura
2. ✅ `02_INSERCION_DATOS.sql` - Datos de prueba
3. ✅ `03_CONSULTAS_REPORTES.sql` - 10 consultas de análisis
4. ✅ `README.md` - Esta documentación

---

## 🎓 Conclusiones

Este proyecto de base de datos demuestra:

- **Análisis de Datos**: Identificación de productos, clientes y tendencias
- **Diseño Relacional**: Tablas bien estructuradas con relaciones claras
- **Normalización**: Base de datos eficiente sin redundancia
- **Reportería**: Consultas complejas que generan información de valor
- **Integridad**: Restricciones que garantizan consistencia de datos

La base de datos está lista para ser usada en operaciones reales del negocio de cafetería.

---

*Proyecto Final - Sistema de Gestión para Cafetería*  
*Generado: Mayo 2026*
````
