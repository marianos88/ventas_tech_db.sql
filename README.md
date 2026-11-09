**Alumno:** Mariano Solle

**Comisión:** 91060

# RetailPro | Análisis de datos de ventas

## Descripción del proyecto

RetailPro es un proyecto práctico de análisis de datos orientado a una empresa distribuidora de tecnología. El objetivo es construir una base de datos relacional, organizar información de clientes, productos, categorías y ventas, y utilizar consultas SQL para responder preguntas de negocio.

El trabajo parte de un conjunto de datos de ejemplo que permite practicar el diseño de tablas, la definición de relaciones, la carga y validación de datos y la elaboración de consultas para obtener indicadores comerciales.

## Objetivos

- Diseñar una base de datos relacional para centralizar la información comercial.
- Definir claves primarias (PK) y claves foráneas (FK) para mantener la integridad referencial.
- Cargar y verificar datos de clientes, productos, categorías y ventas.
- Consultar la información para analizar facturación, pedidos, ticket promedio, recurrencia de clientes y desempeño de productos.
- Preparar los datos para su exploración y visualización en Power BI.

## Herramientas y tecnologías

| Herramienta | Uso en el proyecto |
|---|---|
| **Microsoft SQL Server** | Motor de base de datos utilizado para crear `Ventas_Tech_DB`, sus tablas y relaciones. |
| **T-SQL** | Lenguaje utilizado para definir la estructura, insertar datos y realizar consultas. Se emplean instrucciones como `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, `JOIN`, `GROUP BY`, `HAVING` y funciones de agregación. |
| **SQL Server Management Studio (SSMS)** | Entorno recomendado para conectarse a SQL Server, ejecutar los scripts y revisar los resultados. |
| **Power BI Desktop** | Herramienta de análisis y visualización. El repositorio incluye archivos `.pbix` asociados al desarrollo del proyecto. |
| **GitHub** | Control de versiones y documentación del proyecto. |

## Modelo de datos

La base de datos `Ventas_Tech_DB` contiene cuatro tablas:

| Tabla | Descripción |
|---|---|
| `categorias` | Catálogo de categorías de productos. |
| `clientes` | Datos identificatorios y de registro de los clientes. |
| `productos` | Catálogo de productos, categoría, precio, stock y estado. |
| `ventas` | Registro de operaciones de venta, con cliente, producto, cantidad, precio unitario y fecha. |

### Relaciones

- `productos.id_categoria` referencia a `categorias.id_categoria`.
- `ventas.id_cliente` referencia a `clientes.id_cliente`.
- `ventas.id_producto` referencia a `productos.id_producto`.

Las tablas `categorias`, `clientes` y `productos` funcionan como tablas descriptivas, mientras que `ventas` concentra los registros transaccionales.

## Estructura del repositorio

| Archivo | Contenido |
|---|---|
| [`Pre-entrega-3`](./Pre-entrega-3) | Script principal: crea la base de datos, define las tablas, establece las relaciones, inserta los datos de ejemplo y ejecuta consultas de verificación. |
| [`Consultas SQL de negocio`](./Consultas%20SQL%20de%20negocio) | Consultas para obtener indicadores mensuales, ranking de productos, clientes recurrentes y comparación de facturación mensual. Incluye hallazgos del análisis. |
| [`m5_consultas_joins.sql`](./m5_consultas_joins.sql) | Ejercicios de consultas con `INNER JOIN`, `LEFT JOIN` y `UNION ALL` para combinar y explorar información de distintas tablas. Revisar que las referencias y los datos de ejemplo de cada consulta coincidan con el esquema vigente antes de ejecutarlas. |
| `Pipeline_ETL_Solle_Mariano.pbix` | Archivo de Power BI relacionado con el flujo de preparación y análisis de datos. |
| `Solle_Mariano_Checkpoint2.pbix` | Archivo de Power BI correspondiente a una instancia previa del proyecto. |

## Requisitos

Para ejecutar los scripts SQL se necesita:

1. Una instancia local o remota de **Microsoft SQL Server**.
2. **SQL Server Management Studio (SSMS)** instalado y configurado para conectarse a esa instancia.
3. Permisos para crear bases de datos y tablas en la instancia seleccionada.

Para abrir y explorar los archivos `.pbix`, se necesita **Power BI Desktop**.

## Cómo ejecutar los scripts SQL

### 1. Descargar o clonar el repositorio

Se puede descargar el repositorio desde GitHub o clonarlo desde una terminal:

```bash
git clone https://github.com/marianos88/ventas_tech_db.sql.git
```

Luego, abrir la carpeta descargada.

### 2. Conectarse a SQL Server

1. Abrir SQL Server Management Studio.
2. Conectarse a la instancia de SQL Server correspondiente.
3. En el menú **File > Open > File**, seleccionar el archivo `Pre-entrega-3`.
4. Verificar que la conexión esté apuntando a la instancia correcta.

### 3. Crear y cargar la base de datos

Ejecutar el script `Pre-entrega-3` completo, desde el principio.

Este script realiza las siguientes operaciones:

1. Crea la base de datos `Ventas_Tech_DB`.
2. Selecciona esa base mediante `USE Ventas_Tech_DB`.
3. Elimina las tablas existentes con `DROP TABLE IF EXISTS`, respetando el orden necesario para las dependencias.
4. Crea las cuatro tablas y define sus claves primarias y foráneas.
5. Inserta los datos de ejemplo.
6. Ejecuta consultas `SELECT` para verificar los registros cargados.

Al finalizar, se espera encontrar:

- `categorias`: 4 registros.
- `clientes`: 5 registros.
- `productos`: 6 registros.
- `ventas`: 10 registros.

**Importante:** el script está preparado para una primera ejecución en una instancia donde todavía no exista `Ventas_Tech_DB`. Si la base ya existe, la instrucción `CREATE DATABASE` puede generar un error. Además, las instrucciones `DROP TABLE IF EXISTS` eliminan las tablas existentes y sus datos antes de recrearlas. No ejecutar el script sobre una base con información que se necesite conservar.

### 4. Ejecutar las consultas de negocio

Una vez creada y cargada la base:

1. Abrir el archivo `Consultas SQL de negocio` en SSMS.
2. Ejecutar las consultas, de forma individual o por secciones.
3. Revisar los resultados en la pestaña **Results**.

El archivo incluye consultas para:

- Resumen mensual: pedidos, facturación total y ticket promedio.
- Ranking de los cinco productos con mayor facturación.
- Identificación de clientes recurrentes.
- Comparación de la facturación mensual con el promedio general del período.

El script comienza seleccionando la base con `USE Ventas_Tech_DB`, por lo que debe ejecutarse después de completar correctamente la creación de la base de datos.

### 5. Ejecutar los ejercicios de JOIN

El archivo `m5_consultas_joins.sql` contiene ejercicios de combinación de tablas mediante `INNER JOIN`, `LEFT JOIN` y `UNION ALL`.

Antes de ejecutar cada consulta, comprobar que los nombres de columnas y los registros mencionados correspondan al esquema y a los datos actuales. Este archivo reúne ejercicios de análisis y puede requerir ajustes para alinearse con la versión vigente de la base.

### 6. Abrir los archivos de Power BI

Abrir los archivos `.pbix` con Power BI Desktop. Si se solicita actualizar el origen de datos, configurar la conexión para que apunte a la instancia de SQL Server donde se creó `Ventas_Tech_DB`.

## Alcance y consideraciones del análisis

Los datos incluidos son un conjunto de ejemplo con diez operaciones registradas durante marzo de 2024. Por lo tanto, los resultados permiten demostrar consultas y métodos de análisis, pero no representan una serie histórica suficiente para identificar tendencias, estacionalidad o evolución del negocio.

Los importes de venta se calculan a partir de `cantidad * precio_unitario`. La base no incluye costos de adquisición ni otros costos operativos, por lo que la facturación no debe interpretarse como rentabilidad o ganancia.

---
