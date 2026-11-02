-- === Alumno: Mariano Solle
-- === Comisión: 91060

-- === Designación de la DB Ventas_Tech_DB === USE Ventas_Tech_DB 
-- === Verificación de las tablas con los datos previamente actualizados ===
SELECT * FROM ventas;
SELECT * FROM productos;
SELECT * FROM clientes;

-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: Consolidar el detalle transaccional histórico de ventas (fila por fila) integrando los atributos clave de clientes, productos y categorías mediante INNER JOIN.
SELECT 
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.genero,
    p.nombre_producto,
    p.id_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN productos AS p ON v.id_producto = p.id_producto
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente;
-- Hallazgo: Al mantener el modelo a nivel de fila (granularidad transaccional), se preserva la integridad de los datos para su explotación en Power BI. A diferencia de una consulta agrupada de forma temprana en SQL, esta estructura plana permite al motor DAX de Power BI calcular dinámicamente métricas (como la facturación total o la edad promedio por género) cruzándolas en tiempo real con dimensiones temporales, geográficas o de producto sin perder el detalle de ninguna venta individual.


-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Propósito: Identificar a los clientes registrados en la base de datos que aún no han realizado ninguna compra, permitiendo al equipo de CRM diseñar estrategias de reactivación o bienvenida.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
-- Hallazgo: Mediante la exclusión con LEFT JOIN y WHERE IS NULL, se detectó de forma directa que Carlos Pérez es el único cliente registrado en el sistema que no registra transacciones históricas, convirtiéndose en el público objetivo para la próxima campaña de incentivo de primera compra.


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
