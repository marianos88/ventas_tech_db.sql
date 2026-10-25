-- === Alumno: Mariano Solle
-- === Comisión: 91060

-- === Designación de la DB Ventas_Tech_DB === USE Ventas_Tech_DB 
-- === Verificación de las tablas con los datos previamente actualizados ===
SELECT * FROM ventas;
SELECT * FROM productos;
SELECT * FROM clientes;

-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: Identificar la edad promedio de los géneros que realizaron compras y determinar cuál de ellos registra un mayor volumen de transacciones y facturación.
SELECT
    c.genero,
    AVG(c.edad) AS edad_promedio,
    COUNT(v.id_venta) AS cantidad_ventas,
    SUM(v.cantidad * v.precio_unitario) AS facturacion_total
FROM ventas AS v
INNER JOIN productos AS p ON v.id_producto = p.id_producto
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
GROUP BY c.genero;
-- Hallazgo: El segmento femenino presenta un perfil de mayor madurez con una edad promedio de 38 años (frente a los 26 años del masculino). Asimismo, registra una mayor actividad comercial con 6 ventas realizadas (vs. 4 del masculino), consolidándose como el principal motor de ingresos con una facturación total de 5,414.00 (frente a 1,030.00 del segmento masculino).


-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: detectar clientes registrados que nunca compraron, para que CRM los contacte.
SELECT
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro,
    COUNT(v.id_venta) AS cantidad_ventas
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
GROUP BY 
    c.id_cliente, 
    c.nombre, 
    c.email, 
    c.fecha_registro
ORDER BY 
    cantidad_ventas ASC;
-- Hallazgo: De todos los clientes, Carlos Pérez es el único que no tiene ventas registradas.


-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: detectar productos registrados que no tienen ventas, para generar promociones o reconsiderar compras a futuro.
SELECT
    p.nombre_producto AS producto,
    p.id_categoria AS categoria,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;
-- Hallazgo: De todos los productos, el único que no registra ventas es "Producto Prueba Sin Vender".


-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: Consolidar e igualar en un único reporte los ingresos de la empresa divididos en dos unidades de negocio estratégicas (Canal Online y Canal Presencial).
SELECT 
    canal, 
    SUM(total) AS total_canal
FROM (
    SELECT 
        v.fecha_venta, 
        (v.cantidad * v.precio_unitario) AS total, 
        'Online' AS canal
    FROM ventas AS v
    WHERE v.fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT 
        v.fecha_venta, 
        (v.cantidad * v.precio_unitario) AS total, 
        'Presencial' AS canal
    FROM ventas AS v
    INNER JOIN clientes AS c 
        ON v.id_cliente = c.id_cliente
    WHERE c.ciudad IN ('Buenos Aires', 'Córdoba')
) AS consolidado
GROUP BY canal;
-- Hallazgo:  El análisis consolidado revela que el Canal Online fue la principal fuente de ingresos para la empresa durante el período analizado, acumulando una facturación total de 3620.00, frente al Canal Presencial, el cual registró una facturación de 3160.00.
