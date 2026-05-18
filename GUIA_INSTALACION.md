# 🚀 GUÍA DE INSTALACIÓN Y USO

## 📋 Tabla de Contenidos
1. [Requisitos Previos](#requisitos-previos)
2. [Pasos de Instalación](#pasos-de-instalación)
3. [Verificación de la Instalación](#verificación-de-la-instalación)
4. [Ejecución de Consultas](#ejecución-de-consultas)
5. [Troubleshooting](#troubleshooting)

---

## 🔧 Requisitos Previos

### Software Necesario:
- **SQL Server** 2016 o superior (Express, Standard o Enterprise)
- **SQL Server Management Studio (SSMS)** versión 17.0 o superior
- Acceso de administrador a la instancia de SQL Server

### Conocimientos Mínimos:
- Manejo básico de SSMS
- Entendimiento de SQL básico
- Familiaridad con Management Studio

---

## 📥 Pasos de Instalación

### Paso 1: Descargar los Archivos
```
Descargar desde el repositorio:
✓ 01_CREACION_TABLAS.sql
✓ 02_INSERCION_DATOS.sql
✓ 03_CONSULTAS_REPORTES.sql
✓ README.md (Esta documentación)
```

### Paso 2: Abrir SQL Server Management Studio

1. **Iniciar SSMS**
   - Abrir SQL Server Management Studio
   - Conectar a tu instancia de SQL Server

2. **Crear una Nueva Consulta**
   - Click en "New Query"
   - O usar atajo: `Ctrl + N`

### Paso 3: Ejecutar Script de Creación de Tablas

```sql
-- 1. Copiar el contenido de 01_CREACION_TABLAS.sql
-- 2. Pegar en la ventana de consulta
-- 3. Ejecutar con F5 o "Execute"
```

**Resultado Esperado:**
```
Command(s) completed successfully.
```

### Paso 4: Ejecutar Script de Inserción de Datos

```sql
-- 1. Copiar el contenido de 02_INSERCION_DATOS.sql
-- 2. Pegar en una nueva consulta
-- 3. Ejecutar con F5
```

**Resultado Esperado:**
```
✓ Categorías insertadas: 4
✓ Productos insertados: 18
✓ Clientes insertados: 8
✓ Ventas insertadas: 12
✓ Detalles de venta insertados: 51

Datos de prueba cargados exitosamente.
```

### Paso 5: Ejecutar Consultas de Reportes

```sql
-- 1. Copiar el contenido de 03_CONSULTAS_REPORTES.sql
-- 2. Pegar en una nueva consulta
-- 3. Ejecutar con F5
```

---

## ✅ Verificación de la Instalación

### Verificar que la Base de Datos existe:

```sql
USE CAFETERIA;
GO

-- Contar registros en cada tabla
SELECT 'CATEGORIAS' AS Tabla, COUNT(*) AS Total FROM CATEGORIAS
UNION ALL
SELECT 'PRODUCTOS', COUNT(*) FROM PRODUCTOS
UNION ALL
SELECT 'CLIENTES', COUNT(*) FROM CLIENTES
UNION ALL
SELECT 'VENTAS', COUNT(*) FROM VENTAS
UNION ALL
SELECT 'DETALLES_VENTAS', COUNT(*) FROM DETALLES_VENTAS;
```

**Resultado Esperado:**
| Tabla | Total |
|-------|-------|
| CATEGORIAS | 4 |
| PRODUCTOS | 18 |
| CLIENTES | 8 |
| VENTAS | 12 |
| DETALLES_VENTAS | 51 |

---

## 🔍 Ejecución de Consultas

### Ejecutar Consultas Individuales:

#### Opción 1: Por Separado

```sql
-- Copiar solo UNA consulta del archivo 03_CONSULTAS_REPORTES.sql
-- Ejemplo:
SELECT TOP 10
    p.ID_PRODUCTO,
    p.NOMBRE AS 'Producto',
    c.NOMBRE AS 'Categoría',
    SUM(dv.CANTIDAD) AS 'Total Vendido',
    p.PRECIO AS 'Precio Unitario',
    SUM(dv.SUBTOTAL) AS 'Ingresos Totales'
FROM DETALLES_VENTAS dv
INNER JOIN PRODUCTOS p ON dv.ID_PRODUCTO = p.ID_PRODUCTO
INNER JOIN CATEGORIAS c ON p.ID_CATEGORIA = c.ID_CATEGORIA
GROUP BY p.ID_PRODUCTO, p.NOMBRE, c.NOMBRE, p.PRECIO
ORDER BY [Total Vendido] DESC;
```

#### Opción 2: Todas las Consultas de Golpe

1. Copiar todo el contenido de `03_CONSULTAS_REPORTES.sql`
2. Pegar en SSMS
3. Ejecutar con `F5`
4. Ver los resultados en múltiples ventanas de resultados

---

## 📊 Descripción de Consultas Disponibles

| # | Nombre | Propósito | Datos Clave |
|---|--------|----------|------------|
| 1 | Productos Más Vendidos | Identifica productos estrella | Top 10 por cantidad |
| 2 | Ingresos por Día | Análisis diario de ventas | Período 01-06 Mayo |
| 3 | Clientes Más Frecuentes | Clientes VIP | Top 10 por compras |
| 4 | Ventas por Categoría | Desempeño por categoría | % de ingresos |
| 5 | Métodos de Pago | Forma de pago preferida | Efectivo vs Tarjeta |
| 6 | Stock Actual | Control de inventario | Estado de almacén |
| 7 | Dashboard General | Vista ejecutiva | KPIs principales |
| 8 | Productos Sin Ventas | Bajo movimiento | Decisiones de stock |
| 9 | Detalle de Ventas | Auditoría transaccional | Todas las ventas |
| 10 | Margen y Rentabilidad | Ganancia por producto | Análisis financiero |
| 11 | Tendencias Semanales | Patrón por día semana | Planificación |
| 12 | Análisis de Combos | Productos vendidos juntos | Oportunidades |

---

## 🎯 Ejemplos de Casos de Uso

### Caso 1: Gerente de Operaciones
**Necesidad:** "¿Qué productos venden más?"

```sql
-- Ejecutar Consulta 1: Productos Más Vendidos
-- Resultado: Identifica que Agua Embotellada y Café Americano son los líderes
-- Acción: Aumentar stock de estos productos
```

### Caso 2: Gerente Financiero
**Necesidad:** "¿Cuánto ganamos por día?"

```sql
-- Ejecutar Consulta 2: Ingresos por Día
-- Resultado: Ingresos fluctúan entre $6-18 por día
-- Acción: Proyectar ingresos mensuales ($180-540)
```

### Caso 3: Gerente de Ventas
**Necesidad:** "¿Quiénes son nuestros mejores clientes?"

```sql
-- Ejecutar Consulta 3: Clientes Más Frecuentes
-- Resultado: Juan Pérez con 4 compras (cliente VIP)
-- Acción: Ofrecer programa de descuentos exclusivos
```

### Caso 4: Gerente de Almacén
**Necesidad:** "¿Qué productos tienen bajo stock?"

```sql
-- Ejecutar Consulta 6: Stock Actual
-- Resultado: Ver productos con estado CRÍTICO
-- Acción: Realizar compra inmediata de reorden
```

---

## 🔐 Notas de Seguridad

✅ **Buenas Prácticas:**
- Hacer backup de la BD regularmente
- Cambiar contraseña de SA si es necesario
- Limitar permisos a usuarios estándar
- No ejecutar scripts de fuentes no confiables

⚠️ **Advertencias:**
- Este proyecto es para fines educativos
- No usar en producción sin modificaciones
- Ajustar precios y datos según necesidad real

---

## 🐛 Troubleshooting

### Problema 1: "Cannot open database 'CAFETERIA'"

**Solución:**
```sql
-- Verificar que la BD existe
SELECT name FROM sys.databases WHERE name = 'CAFETERIA';

-- Si no existe, ejecutar 01_CREACION_TABLAS.sql primero
```

### Problema 2: "Foreign key constraint failed"

**Solución:**
```sql
-- Ejecutar scripts en orden:
-- 1. 01_CREACION_TABLAS.sql (primero)
-- 2. 02_INSERCION_DATOS.sql (segundo)
-- 3. 03_CONSULTAS_REPORTES.sql (tercero)
```

### Problema 3: "Conversion failed when converting datetime"

**Solución:**
- Verificar formato de fechas en tu servidor
- Usar formato estándar ISO: YYYY-MM-DD

### Problema 4: "Cannot insert NULL into NOT NULL column"

**Solución:**
```sql
-- Verificar que todos los datos requeridos se proporcionan
-- Revisar restricciones con:
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'NOMBRE_TABLA'
```

---

## 📈 Expansión del Proyecto

### Agregar Más Datos:

```sql
-- Insertar nuevo cliente
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, CEDULA, CIUDAD)
VALUES ('Nuevo', 'Cliente', 'email@mail.com', '809-555-9999', '12345679', 'Santo Domingo');

-- Insertar nueva venta
INSERT INTO VENTAS (ID_CLIENTE, FECHA_VENTA, TOTAL, METODO_PAGO)
VALUES (9, GETDATE(), 15.50, 'Efectivo');

-- Insertar detalle de venta
INSERT INTO DETALLES_VENTAS (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL)
VALUES (13, 1, 2, 2.50, 5.00);
```

### Crear Nuevas Consultas:

```sql
-- Ejemplo: Clientes por ciudad
SELECT CIUDAD, COUNT(*) AS [Clientes por Ciudad]
FROM CLIENTES
GROUP BY CIUDAD
ORDER BY COUNT(*) DESC;
```

---

## 📞 Soporte

### Si necesitas ayuda:

1. **Verificar sintaxis SQL** en la consulta
2. **Revisar el tipo de error** en el mensaje de SSMS
3. **Consultar la documentación** de SQL Server
4. **Buscar en Stack Overflow** con el código de error

---

## 📚 Recursos Adicionales

- [Microsoft SQL Server Documentation](https://docs.microsoft.com/sql/)
- [SQL Server Management Studio](https://docs.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms)
- [Tutorial de SQL básico](https://www.w3schools.com/sql/)

---

## ✨ Checklist de Implementación

```
[ ] Descargar archivos del repositorio
[ ] Instalar SQL Server y SSMS
[ ] Conectar a instancia de SQL Server
[ ] Ejecutar 01_CREACION_TABLAS.sql
[ ] Ejecutar 02_INSERCION_DATOS.sql
[ ] Verificar conteo de registros
[ ] Ejecutar 03_CONSULTAS_REPORTES.sql
[ ] Revisar resultados de consultas
[ ] Hacer backup de la BD
[ ] Documentar cambios realizados
[ ] ¡Proyecto completado!
```

---

## 🎓 Notas para el Estudiante

Este proyecto demuestra:
- ✅ Diseño de BD relacional
- ✅ Normalización (3FN)
- ✅ Integridad referencial
- ✅ Consultas complejas con JOINs
- ✅ Análisis de datos
- ✅ Reportería empresarial

**¡Felicidades! Has completado tu proyecto final de Base de Datos I** 🎉

---

*Generado: Mayo 2026*
*Proyecto: Sistema de Gestión para Cafetería*
