-- ============================================================
--  NexShop Group S.A. — Datos de Prueba
--  Autor: Juan Antonio Reyes Linares
--  Fichero: datos.sql
--  Descripcion: INSERT realistas para poder ejecutar y probar
--               todas las consultas del proyecto.
-- ============================================================

USE nexshop;

-- ============================================================
-- SEDES
-- ============================================================
INSERT INTO sedes (nombre, tipo, ciudad, direccion, telefono) VALUES
('Almacen Central Valencia', 'almacen_central', 'Valencia', 'Polígono Industrial Vara de Quart, Nave 12', '963 100 001'),
('Tienda Valencia Centro',   'tienda_fisica',   'Valencia', 'Calle Colón 45, Local 2',                  '963 100 002'),
('Tienda Madrid Gran Via',   'tienda_fisica',   'Madrid',   'Gran Via 28, Planta Baja',                 '911 200 003'),
('Tienda Barcelona Diagonal','tienda_fisica',   'Barcelona','Avinguda Diagonal 370',                    '932 300 004');

-- ============================================================
-- EMPLEADOS
-- ============================================================
INSERT INTO empleados (nombre, apellidos, dni, email_corporativo, fecha_incorporacion, cargo, id_sede) VALUES
('David',   'Cano Ruiz',       '11111111A', 'd.cano@nexshop.es',      '2015-03-01', 'Responsable de Logística',    1),
('Marta',   'Gil Soler',       '22222222B', 'm.gil@nexshop.es',        '2016-06-15', 'Responsable de Almacén',      1),
('Carlos',  'Vidal Pérez',     '33333333C', 'c.vidal@nexshop.es',      '2017-01-10', 'Encargado Valencia',          2),
('Sofía',   'Navarro López',   '44444444D', 's.navarro@nexshop.es',    '2017-09-20', 'Vendedora Valencia',          2),
('Javier',  'Torres Blanco',   '55555555E', 'j.torres@nexshop.es',     '2018-04-05', 'Encargado Madrid',            3),
('Laura',   'Pons Ferrer',     '66666666F', 'l.pons@nexshop.es',       '2019-02-14', 'Jefa Atención al Cliente',    1),
('Andrés',  'Molina Castro',   '77777777G', 'a.molina@nexshop.es',     '2020-07-01', 'Agente Atención al Cliente',  1),
('Elena',   'Ramos Ortega',    '88888888H', 'e.ramos@nexshop.es',      '2021-03-22', 'Agente Atención al Cliente',  1),
('Raúl',    'Fuentes Mora',    '99999999I', 'r.fuentes@nexshop.es',    '2022-01-15', 'Encargado Barcelona',         4),
('Nuria',   'Sanz Herrero',    '10101010J', 'n.sanz@nexshop.es',       '2022-08-30', 'Vendedora Barcelona',         4),
('Ana',     'Ferrer Díaz',     '12121212K', 'a.ferrer@nexshop.es',     '2015-01-15', 'Directora de Operaciones',    1),
('Sergio',  'Blanco Romero',   '13131313L', 's.blanco@nexshop.es',     '2015-02-01', 'Responsable IT',              1);

-- ============================================================
-- PROVEEDORES
-- ============================================================
INSERT INTO proveedores (razon_social, cif, email, telefono, id_representante) VALUES
('TechDistrib S.L.',      'B12345678', 'ventas@techdistrib.es',    '910 001 001', 1),
('InfoSupply España S.A.','A23456789', 'comercial@infosupply.es',  '910 002 002', 1),
('ElectroMayoristas S.L.','B34567890', 'pedidos@electromay.es',    '910 003 003', 11),
('DigitalParts EU S.L.',  'B45678901', 'info@digitalparts.eu',     '910 004 004', 11);

-- ============================================================
-- CATEGORIAS (árbol)
-- ============================================================
INSERT INTO categorias (nombre, id_padre) VALUES
('Informática',    NULL),   -- 1
('Electrónica',    NULL),   -- 2
('Periféricos',    NULL),   -- 3
('Portátiles',     1),      -- 4
('Sobremesa',      1),      -- 5
('Tablets',        2),      -- 6
('Smartphones',    2),      -- 7
('Ratones',        3),      -- 8
('Teclados',       3),      -- 9
('Monitores',      3),      -- 10
('Portátiles Gaming',     4),  -- 11
('Portátiles Oficina',    4),  -- 12
('Portátiles Ultraligeros',4); -- 13

-- ============================================================
-- PRODUCTOS
-- ============================================================
INSERT INTO productos (referencia, nombre, descripcion, pvp_actual, activo, id_subcategoria) VALUES
('PORT-GAM-001', 'Asus ROG Strix G15',          'Portátil gaming 15.6" RTX 4060',        1299.99, 1, 11),
('PORT-GAM-002', 'MSI Katana 15',               'Portátil gaming 15.6" i7 RTX 3060',      999.00, 1, 11),
('PORT-OFI-001', 'Lenovo ThinkPad E15',         'Portátil oficina 15.6" i5 16GB',          749.00, 1, 12),
('PORT-OFI-002', 'HP EliteBook 840 G10',        'Portátil oficina 14" i7 empresarial',     1099.00, 1, 12),
('PORT-ULT-001', 'Apple MacBook Air M2',        'Portátil ultraligero 13.6" M2 8GB',      1199.00, 1, 13),
('PORT-ULT-002', 'Dell XPS 13 Plus',            'Portátil ultraligero 13.4" i7',          1349.00, 1, 13),
('TAB-AND-001',  'Samsung Galaxy Tab S9',       'Tablet 11" Android 256GB',                799.00, 1, 6),
('TAB-AND-002',  'Xiaomi Pad 6 Pro',            'Tablet 11" Snapdragon 256GB',             449.00, 1, 6),
('SMAR-001',     'Samsung Galaxy S24',          'Smartphone 6.2" 128GB',                   849.00, 1, 7),
('SMAR-002',     'iPhone 15',                   'Smartphone 6.1" 128GB',                   979.00, 1, 7),
('RAT-001',      'Logitech MX Master 3S',       'Ratón inalámbrico ergonómico',            109.99, 1, 8),
('RAT-002',      'Razer DeathAdder V3',         'Ratón gaming 30000 DPI',                  69.99, 1, 8),
('TEC-001',      'Keychron K8 Pro',             'Teclado mecánico inalámbrico',            109.00, 1, 9),
('TEC-002',      'Logitech MX Keys S',          'Teclado inalámbrico retroiluminado',       99.00, 1, 9),
('MON-001',      'LG 27GP850-B 27"',            'Monitor gaming 27" 165Hz QHD',            349.00, 1, 10),
('MON-002',      'Dell UltraSharp U2722D',      'Monitor profesional 27" 4K',              549.00, 1, 10);

-- ============================================================
-- HISTORIAL DE PRECIOS
-- ============================================================
INSERT INTO historial_precios (id_producto, pvp, fecha_inicio, fecha_fin) VALUES
(1, 1399.99, '2023-01-01', '2023-06-30'),
(1, 1349.99, '2023-07-01', '2023-12-31'),
(1, 1299.99, '2024-01-01', NULL),
(3,  799.00, '2023-01-01', '2023-09-30'),
(3,  749.00, '2023-10-01', NULL),
(5, 1299.00, '2023-01-01', '2023-11-30'),
(5, 1199.00, '2023-12-01', NULL),
(9,  899.00, '2023-01-01', '2023-12-31'),
(9,  849.00, '2024-01-01', NULL);

-- ============================================================
-- PROMOCIONES
-- ============================================================
INSERT INTO promociones (nombre, descripcion, descuento_pct, fecha_inicio, fecha_fin) VALUES
('Black Friday 2023',   'Descuentos del 20% en portátiles',       20.00, '2023-11-24', '2023-11-27'),
('Rebajas Enero 2024',  'Liquidación de stock invernal',           15.00, '2024-01-02', '2024-01-15'),
('Vuelta al Cole 2024', 'Descuentos en portátiles y tablets',      10.00, '2024-09-01', '2024-09-30'),
('Cyber Monday 2023',   'Solo online, 25% en smartphones',         25.00, '2023-11-27', '2023-11-27'),
('Promo Ratones Mayo',  'Descuento en periféricos seleccionados',   12.00, '2024-05-01', '2024-05-31');

INSERT INTO promocion_producto (id_promocion, id_producto) VALUES
(1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),
(2, 1),(2, 3),(2, 7),
(3, 3),(3, 4),(3, 7),(3, 8),
(4, 9),(4, 10),
(5, 11),(5, 12);

-- ============================================================
-- CONDICIONES PROVEEDOR-PRODUCTO
-- ============================================================
INSERT INTO condiciones_proveedor_producto (id_proveedor, id_producto, precio_coste, plazo_entrega, fecha_inicio, fecha_fin) VALUES
(1, 1,  980.00, 7,  '2023-01-01', '2023-12-31'),
(1, 1,  940.00, 5,  '2024-01-01', NULL),
(2, 1, 1010.00, 10, '2023-01-01', '2023-12-31'),
(1, 2,  720.00, 7,  '2023-01-01', NULL),
(1, 3,  540.00, 5,  '2023-01-01', '2023-09-30'),
(1, 3,  510.00, 5,  '2023-10-01', NULL),
(3, 5,  880.00, 14, '2023-01-01', NULL),
(2, 9,  600.00, 10, '2023-01-01', NULL),
(3, 10, 700.00, 12, '2023-01-01', NULL),
(4, 11,  65.00, 3,  '2023-01-01', NULL),
(4, 12,  48.00, 3,  '2023-01-01', NULL);

-- ============================================================
-- STOCK POR UBICACION
-- ============================================================
INSERT INTO stock_ubicacion (id_producto, id_sede, cantidad) VALUES
-- Almacen central (1)
(1,1,50),(2,1,40),(3,1,60),(4,1,30),(5,1,25),(6,1,20),
(7,1,45),(8,1,35),(9,1,55),(10,1,40),(11,1,80),(12,1,70),
(13,1,60),(14,1,50),(15,1,30),(16,1,20),
-- Valencia (2)
(1,2,5),(2,2,4),(3,2,8),(5,2,3),(9,2,6),(10,2,4),(11,2,12),(12,2,10),
-- Madrid (3)
(1,3,6),(3,3,7),(4,3,4),(5,3,2),(7,3,5),(9,3,5),(11,3,8),(13,3,6),
-- Barcelona (4)
(2,4,5),(3,4,6),(6,4,3),(8,4,7),(10,4,3),(12,4,9),(14,4,8),(15,4,4);

-- ============================================================
-- TRANSFERENCIAS DE STOCK
-- ============================================================
INSERT INTO transferencias_stock (id_producto, id_sede_origen, id_sede_destino, cantidad, fecha, id_empleado_auth) VALUES
(1, 1, 2, 5, '2024-02-10', 1),
(3, 1, 3, 10, '2024-03-05', 1),
(11, 1, 4, 8, '2024-04-15', 11),
(5, 2, 3, 2, '2024-05-20', 3),
(9, 1, 2, 6, '2024-06-01', 1);

-- ============================================================
-- CLIENTES REGISTRADOS
-- ============================================================
INSERT INTO clientes (nombre, apellidos, email, password_hash, fecha_nacimiento, fecha_registro) VALUES
('Alicia',   'Martínez Torres',  'alicia.m@email.com',   'hash_a1', '1990-03-14', '2022-01-10 10:00:00'),
('Bruno',    'García Sánchez',   'bruno.g@email.com',    'hash_b2', '1985-07-22', '2022-03-25 11:30:00'),
('Carla',    'Fernández Ruiz',   'carla.f@email.com',    'hash_c3', '1995-11-05', '2022-06-14 09:15:00'),
('Daniel',   'López Herrera',    'daniel.l@email.com',   'hash_d4', '1988-04-30', '2023-01-08 16:45:00'),
('Eva',      'Pérez Molina',     'eva.p@email.com',      'hash_e5', '1992-09-18', '2023-02-20 14:20:00'),
('Fernando', 'Jiménez Lara',     'fernando.j@email.com', 'hash_f6', '1979-12-03', '2023-05-11 08:00:00'),
('Gloria',   'Romero Vega',      'gloria.r@email.com',   'hash_g7', '2001-06-25', '2023-09-30 17:10:00'),
('Hector',   'Álvarez Cruz',     'hector.a@email.com',   'hash_h8', '1996-01-09', '2024-01-15 12:00:00'),
('Irene',    'Moreno Castillo',  'irene.mo@email.com',   'hash_i9', '1983-08-17', '2024-02-28 10:30:00'),
('Jorge',    'Muñoz Peña',       'jorge.mu@email.com',   'hash_j10','1991-05-12', '2024-04-03 09:45:00');

-- ============================================================
-- DIRECCIONES DE CLIENTES
-- ============================================================
INSERT INTO direcciones_cliente (id_cliente, alias, calle, numero, piso, codigo_postal, ciudad, pais) VALUES
(1, 'domicilio', 'Calle Mayor',        '12', '3B', '28001', 'Madrid',    'España'),
(1, 'trabajo',   'Paseo de la Reforma','45', '7',  '28002', 'Madrid',    'España'),
(2, 'domicilio', 'Carrer de Balmes',   '80', '2A', '08007', 'Barcelona', 'España'),
(3, 'domicilio', 'Avenida de la Paz',  '33', '1',  '46004', 'Valencia',  'España'),
(4, 'domicilio', 'Calle Alcalá',       '200','4C', '28028', 'Madrid',    'España'),
(5, 'domicilio', 'Gran Vía',           '15', 'BJ', '48001', 'Bilbao',    'España'),
(6, 'domicilio', 'Ronda de Dalt',      '60', '5D', '08035', 'Barcelona', 'España'),
(7, 'domicilio', 'Calle Sierpes',      '20', '2',  '41004', 'Sevilla',   'España'),
(8, 'domicilio', 'Calle Larios',       '5',  '1A', '29015', 'Málaga',    'España'),
(9, 'domicilio', 'Paseo Maritimo',     '100','6B', '07014', 'Palma',     'España'),
(10,'domicilio', 'Calle Triana',       '8',  '3',  '35002', 'Las Palmas','España');

-- ============================================================
-- PEDIDOS ONLINE
-- ============================================================
INSERT INTO pedidos_online (id_cliente, id_direccion, fecha_pedido, estado, total, puntos_canjeados) VALUES
(1, 1, '2024-01-15 10:30:00', 'entregado',   1299.99,  0),
(1, 1, '2024-03-22 14:00:00', 'entregado',    109.99,  0),
(2, 3, '2024-02-10 09:15:00', 'entregado',    999.00,  0),
(3, 4, '2024-03-05 11:00:00', 'entregado',    749.00,  0),
(4, 5, '2024-04-18 16:30:00', 'enviado',     1099.00,500),
(5, 6, '2024-05-02 08:45:00', 'entregado',    849.00,  0),
(6, 8, '2024-05-20 13:00:00', 'en_proceso',  1199.00,  0),
(7, 9, '2024-06-01 10:00:00', 'pendiente',    449.00,  0),
(8,10, '2024-06-03 17:20:00', 'confirmado',   979.00,  0),
(1, 2, '2024-06-05 09:00:00', 'pendiente',    349.00,  0),
(3, 4, '2024-01-20 15:00:00', 'entregado',    109.00,  0),
(2, 3, '2023-11-25 11:00:00', 'entregado',   1279.99,  0);  -- Black Friday

-- ============================================================
-- LINEAS DE PEDIDO
-- ============================================================
INSERT INTO lineas_pedido (id_pedido, id_producto, cantidad, precio_unit, descuento_pct) VALUES
(1,  1, 1, 1299.99, 0),
(2,  11,1,  109.99, 0),
(3,  2, 1,  999.00, 0),
(4,  3, 1,  749.00, 0),
(5,  4, 1, 1099.00, 0),
(6,  9, 1,  849.00, 0),
(7,  5, 1, 1199.00, 0),
(8,  8, 1,  449.00, 0),
(9, 10, 1,  979.00, 0),
(10,15, 1,  349.00, 0),
(11,13, 1,  109.00, 0),
(12, 1, 1, 1299.99,20),  -- Black Friday 20%
(12,11, 1,  109.99, 0);

-- ============================================================
-- ENVIOS
-- ============================================================
INSERT INTO envios (id_pedido, id_sede_origen, numero_seguimiento, transportista, fecha_estimada, fecha_entrega_real, estado) VALUES
(1,  1, 'SEUR-000001', 'SEUR',  '2024-01-18', '2024-01-17', 'entregado'),
(2,  1, 'SEUR-000002', 'SEUR',  '2024-03-25', '2024-03-25', 'entregado'),
(3,  1, 'MRW-000001',  'MRW',   '2024-02-13', '2024-02-14', 'entregado'),
(4,  1, 'MRW-000002',  'MRW',   '2024-03-08', '2024-03-08', 'entregado'),
(5,  1, 'SEUR-000003', 'SEUR',  '2024-04-22', NULL,          'en_transito'),
(6,  1, 'CORREOS-001', 'Correos','2024-05-06', '2024-05-07', 'entregado'),
(7,  1, 'SEUR-000004', 'SEUR',  '2024-05-24', NULL,          'preparando'),
(9,  1, 'MRW-000003',  'MRW',   '2024-06-07', NULL,          'preparando'),
(12, 1, 'SEUR-BF001',  'SEUR',  '2024-11-29', '2024-11-29', 'entregado'),
(12, 3, 'SEUR-BF002',  'SEUR',  '2024-11-30', '2024-11-30', 'entregado');  -- envio parcial desde Madrid

-- ============================================================
-- VENTAS PRESENCIALES
-- ============================================================
INSERT INTO ventas_presenciales (id_sede, id_empleado, id_cliente, fecha_venta, total) VALUES
(2, 4, NULL, '2024-01-10 11:00:00',  999.00),  -- cliente no registrado
(2, 4, 1,    '2024-02-14 17:30:00',  109.99),
(3, 5, NULL, '2024-03-08 10:15:00', 1299.99),
(4, 9, 3,    '2024-04-22 12:00:00',  449.00),
(2, 3, 2,    '2024-05-05 16:45:00',   99.00),
(3, 5, NULL, '2024-05-18 14:00:00',  849.00),
(4,10, 5,    '2024-06-02 10:30:00',  109.00);

-- ============================================================
-- LINEAS DE VENTA PRESENCIAL
-- ============================================================
INSERT INTO lineas_venta_presencial (id_venta, id_producto, cantidad, precio_unit) VALUES
(1, 2,  1, 999.00),
(2, 12, 1, 109.99),
(3, 1,  1, 1299.99),
(4, 8,  1, 449.00),
(5, 14, 1, 99.00),
(6, 9,  1, 849.00),
(7, 13, 1, 109.00);

-- ============================================================
-- DEVOLUCIONES PRESENCIALES
-- ============================================================
INSERT INTO devoluciones_presenciales (id_venta, id_producto, cantidad, fecha, motivo) VALUES
(1, 2, 1, '2024-01-17', 'Producto defectuoso. Bisagra rota al abrirlo.'),
(5,14, 1, '2024-05-12', 'El cliente cambió de opinión. Teclado sin usar.');

-- ============================================================
-- TICKETS DE INCIDENCIA
-- ============================================================
INSERT INTO tickets_incidencia (id_cliente, id_pedido, id_agente, asunto, descripcion, estado, fecha_apertura, fecha_cierre, nota_resolucion) VALUES
(1, 1,  7, 'Retraso en entrega',         'El pedido tardó más de lo indicado.',                'resuelto',   '2024-01-19 09:00:00', '2024-01-20 10:00:00', 'El transportista reportó incidencia de tráfico. Disculpas ofrecidas.'),
(3, 4,  8, 'Producto dañado en envío',   'El portátil llegó con la pantalla rayada.',          'resuelto',   '2024-03-09 14:00:00', '2024-03-15 16:00:00', 'Se tramitó devolución y reenvío sin cargo.'),
(5, 6,  7, 'Quiero devolver el pedido',  'No me hace falta, lo compré por duplicado.',         'en_gestion', '2024-05-10 11:00:00', NULL, NULL),
(NULL,NULL,8, 'Consulta sobre garantías',  'Un cliente pregunta cuánto dura la garantía oficial.','resuelto', '2024-04-05 10:00:00', '2024-04-05 10:30:00', 'Se informó: 2 años garantía legal + garantía fabricante según producto.'),
(2, 3,  7, 'Factura incorrecta',         'El IVA aparece mal calculado en la factura.',        'resuelto',   '2024-02-15 09:30:00', '2024-02-16 11:00:00', 'Error corregido, factura rectificativa enviada por email.');

-- ============================================================
-- VALORACIONES
-- ============================================================
INSERT INTO valoraciones (id_cliente, id_producto, puntuacion, comentario, fecha, verificada) VALUES
(1,  1, 5, 'Increíble portátil, rinde genial en todos los juegos.',            '2024-01-25 18:00:00', 1),
(1, 11, 4, 'Ratón muy cómodo, pero el scroll a veces va un poco duro.',        '2024-04-01 10:00:00', 1),
(2,  2, 4, 'Buena relación calidad-precio. Un poco caliente bajo carga.',      '2024-02-20 20:00:00', 1),
(3,  3, 5, 'Perfecto para el trabajo. Batería dura todo el día.',              '2024-03-15 09:00:00', 1),
(3,  8, 3, 'La tablet va bien, pero la cámara deja que desear.',               '2024-05-01 11:30:00', 1),
(5,  9, 4, 'Muy buen teléfono. La cámara es una pasada.',                      '2024-05-20 17:00:00', 1),
(6,  5, 5, 'El MacBook Air M2 es simplemente perfecto. No lo cambio por nada.','2024-06-01 12:00:00', 0),  -- sin compra confirmada (histórico)
(4,  4, 4, 'Portátil sólido para empresa. Un poco pesado para viajar.',        '2024-05-05 08:30:00', 0);  -- histórico sin verificar

-- ============================================================
-- MOVIMIENTOS DE PUNTOS
-- ============================================================
INSERT INTO movimientos_puntos (id_cliente, id_pedido, tipo, puntos, descripcion, fecha) VALUES
(1, 1,  'ganados',  12999, 'Puntos por pedido #1 (1299.99€ × 10)',     '2024-01-17 12:00:00'),
(1, 2,  'ganados',   1099, 'Puntos por pedido #2 (109.99€ × 10)',      '2024-03-25 18:00:00'),
(2, 3,  'ganados',   9990, 'Puntos por pedido #3 (999.00€ × 10)',      '2024-02-14 11:00:00'),
(3, 4,  'ganados',   7490, 'Puntos por pedido #4 (749.00€ × 10)',      '2024-03-08 16:00:00'),
(4, 5,  'ganados',  10990, 'Puntos por pedido #5 (1099.00€ × 10)',     '2024-04-20 09:00:00'),
(4, 5,  'canjeados',  500, 'Canje de 500 puntos en pedido #5',         '2024-04-18 16:30:00'),
(5, 6,  'ganados',   8490, 'Puntos por pedido #6 (849.00€ × 10)',      '2024-05-07 14:00:00'),
(1, 10, 'ganados',   3490, 'Puntos por pedido #10 (349.00€ × 10)',     '2024-06-06 10:00:00'),
(3, 11, 'ganados',   1090, 'Puntos por pedido #11 (109.00€ × 10)',     '2024-01-25 10:00:00'),
(2, 12, 'ganados',  13889, 'Puntos por pedido #12 Black Friday',       '2023-11-29 09:00:00');

-- ============================================================
-- VINCULACIONES HISTORIAL PRESENCIAL <-> CUENTA ONLINE
-- ============================================================
INSERT INTO vinculaciones_historial (id_cliente, id_venta, fecha_solicitud) VALUES
(1, 2, '2024-02-15'),   -- Alicia vincula su compra presencial en Valencia
(3, 4, '2024-04-25');   -- Carla vincula su compra presencial en Barcelona

-- ============================================================
-- PRODUCTO <-> TIENDA (disponibilidad en tiendas fisicas)
-- ============================================================
INSERT INTO producto_tienda (id_producto, id_sede, disponible) VALUES
(1,2,1),(1,3,1),(1,4,1),
(2,2,1),(2,4,1),
(3,2,1),(3,3,1),(3,4,1),
(4,3,1),
(5,2,1),(5,3,1),
(7,3,1),
(8,2,1),(8,4,1),
(9,2,1),(9,3,1),
(11,2,1),(11,3,1),(11,4,1),
(12,2,1),(12,4,1),
(13,2,1),(13,3,1),
(14,2,1),(14,4,1),
(15,4,1);
