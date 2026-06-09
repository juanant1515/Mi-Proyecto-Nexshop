-- ============================================================
--  NexShop Group S.A. — Base de Datos
--  Autor: Juan Antonio Reyes Linares
--  Fichero: schema.sql
--  Descripcion: Creacion de todas las tablas, PKs, FKs y
--               restricciones CHECK del modelo relacional.
-- ============================================================

DROP DATABASE IF EXISTS nexshop;
CREATE DATABASE nexshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nexshop;

-- ============================================================
-- 1. SEDES (tiendas fisicas + almacen central)
-- ============================================================
CREATE TABLE sedes (
    id_sede       INT AUTO_INCREMENT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    tipo          ENUM('tienda_fisica','almacen_central') NOT NULL,
    ciudad        VARCHAR(100) NOT NULL,
    direccion     VARCHAR(255),
    telefono      VARCHAR(20)
);

-- ============================================================
-- 2. EMPLEADOS
-- ============================================================
CREATE TABLE empleados (
    id_empleado        INT AUTO_INCREMENT PRIMARY KEY,
    nombre             VARCHAR(100) NOT NULL,
    apellidos          VARCHAR(150) NOT NULL,
    dni                CHAR(9) NOT NULL UNIQUE,
    email_corporativo  VARCHAR(150) NOT NULL UNIQUE,
    fecha_incorporacion DATE NOT NULL,
    cargo              VARCHAR(100),
    id_sede            INT NOT NULL,
    CONSTRAINT fk_empleado_sede FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

-- ============================================================
-- 3. PROVEEDORES
-- ============================================================
CREATE TABLE proveedores (
    id_proveedor      INT AUTO_INCREMENT PRIMARY KEY,
    razon_social      VARCHAR(200) NOT NULL,
    cif               VARCHAR(20) UNIQUE,
    email             VARCHAR(150),
    telefono          VARCHAR(20),
    id_representante  INT,  -- empleado de NexShop asignado
    CONSTRAINT fk_proveedor_representante FOREIGN KEY (id_representante) REFERENCES empleados(id_empleado)
);

-- ============================================================
-- 4. CATEGORIAS (arbol: categoria -> subcategoria)
-- ============================================================
CREATE TABLE categorias (
    id_categoria   INT AUTO_INCREMENT PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    id_padre       INT DEFAULT NULL,  -- NULL = categoria raiz
    CONSTRAINT fk_categoria_padre FOREIGN KEY (id_padre) REFERENCES categorias(id_categoria)
);

-- ============================================================
-- 5. PRODUCTOS
-- ============================================================
CREATE TABLE productos (
    id_producto     INT AUTO_INCREMENT PRIMARY KEY,
    referencia      VARCHAR(50) NOT NULL UNIQUE,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    pvp_actual      DECIMAL(10,2) NOT NULL CHECK (pvp_actual >= 0),
    activo          TINYINT(1) NOT NULL DEFAULT 1,
    id_subcategoria INT NOT NULL,
    CONSTRAINT fk_producto_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES categorias(id_categoria)
);

-- ============================================================
-- 6. HISTORIAL DE PRECIOS (pvp que cambia con el tiempo)
-- ============================================================
CREATE TABLE historial_precios (
    id_historial   INT AUTO_INCREMENT PRIMARY KEY,
    id_producto    INT NOT NULL,
    pvp            DECIMAL(10,2) NOT NULL CHECK (pvp >= 0),
    fecha_inicio   DATE NOT NULL,
    fecha_fin      DATE,
    CONSTRAINT fk_histprecio_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT chk_fechas_precio CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

-- ============================================================
-- 7. PROMOCIONES
-- ============================================================
CREATE TABLE promociones (
    id_promocion      INT AUTO_INCREMENT PRIMARY KEY,
    nombre            VARCHAR(150) NOT NULL,
    descripcion       TEXT,
    descuento_pct     DECIMAL(5,2) NOT NULL CHECK (descuento_pct > 0 AND descuento_pct <= 100),
    fecha_inicio      DATE NOT NULL,
    fecha_fin         DATE NOT NULL,
    CONSTRAINT chk_fechas_promo CHECK (fecha_fin >= fecha_inicio)
);

-- Relacion N:M  promocion <-> producto
CREATE TABLE promocion_producto (
    id_promocion   INT NOT NULL,
    id_producto    INT NOT NULL,
    PRIMARY KEY (id_promocion, id_producto),
    CONSTRAINT fk_pp_promocion FOREIGN KEY (id_promocion) REFERENCES promociones(id_promocion),
    CONSTRAINT fk_pp_producto  FOREIGN KEY (id_producto)  REFERENCES productos(id_producto)
);

-- ============================================================
-- 8. CONDICIONES PROVEEDOR-PRODUCTO (historico negociado)
-- ============================================================
CREATE TABLE condiciones_proveedor_producto (
    id_condicion     INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor     INT NOT NULL,
    id_producto      INT NOT NULL,
    precio_coste     DECIMAL(10,2) NOT NULL CHECK (precio_coste >= 0),
    plazo_entrega    INT NOT NULL CHECK (plazo_entrega > 0),  -- dias
    fecha_inicio     DATE NOT NULL,
    fecha_fin        DATE,
    CONSTRAINT fk_cpp_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    CONSTRAINT fk_cpp_producto  FOREIGN KEY (id_producto)  REFERENCES productos(id_producto),
    CONSTRAINT chk_fechas_cpp   CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

-- ============================================================
-- 9. STOCK POR UBICACION
-- ============================================================
CREATE TABLE stock_ubicacion (
    id_stock    INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sede     INT NOT NULL,
    cantidad    INT NOT NULL DEFAULT 0 CHECK (cantidad >= 0),
    UNIQUE KEY uq_stock_prod_sede (id_producto, id_sede),
    CONSTRAINT fk_stock_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT fk_stock_sede     FOREIGN KEY (id_sede)     REFERENCES sedes(id_sede)
);

-- ============================================================
-- 10. TRANSFERENCIAS INTERNAS DE STOCK
-- ============================================================
CREATE TABLE transferencias_stock (
    id_transferencia  INT AUTO_INCREMENT PRIMARY KEY,
    id_producto       INT NOT NULL,
    id_sede_origen    INT NOT NULL,
    id_sede_destino   INT NOT NULL,
    cantidad          INT NOT NULL CHECK (cantidad > 0),
    fecha             DATE NOT NULL,
    id_empleado_auth  INT NOT NULL,
    CONSTRAINT fk_ts_producto FOREIGN KEY (id_producto)      REFERENCES productos(id_producto),
    CONSTRAINT fk_ts_origen   FOREIGN KEY (id_sede_origen)   REFERENCES sedes(id_sede),
    CONSTRAINT fk_ts_destino  FOREIGN KEY (id_sede_destino)  REFERENCES sedes(id_sede),
    CONSTRAINT fk_ts_empleado FOREIGN KEY (id_empleado_auth) REFERENCES empleados(id_empleado),
    CONSTRAINT chk_ts_sedes   CHECK (id_sede_origen <> id_sede_destino)
);

-- ============================================================
-- 11. CLIENTES REGISTRADOS (online)
-- ============================================================
CREATE TABLE clientes (
    id_cliente        INT AUTO_INCREMENT PRIMARY KEY,
    nombre            VARCHAR(100) NOT NULL,
    apellidos         VARCHAR(150) NOT NULL,
    email             VARCHAR(150) NOT NULL UNIQUE,
    password_hash     VARCHAR(255) NOT NULL,
    fecha_nacimiento  DATE,
    fecha_registro    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    activo            TINYINT(1) NOT NULL DEFAULT 1
);

-- ============================================================
-- 12. DIRECCIONES DE CLIENTES
-- ============================================================
CREATE TABLE direcciones_cliente (
    id_direccion  INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente    INT NOT NULL,
    alias         VARCHAR(50),  -- 'domicilio', 'trabajo', etc.
    calle         VARCHAR(200) NOT NULL,
    numero        VARCHAR(10),
    piso          VARCHAR(20),
    codigo_postal VARCHAR(10) NOT NULL,
    ciudad        VARCHAR(100) NOT NULL,
    pais          VARCHAR(100) NOT NULL DEFAULT 'España',
    CONSTRAINT fk_dir_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ============================================================
-- 13. PEDIDOS ONLINE
-- ============================================================
CREATE TABLE pedidos_online (
    id_pedido         INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente        INT NOT NULL,
    id_direccion      INT NOT NULL,
    fecha_pedido      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado            ENUM('pendiente','confirmado','en_proceso','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    total             DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    puntos_canjeados  INT NOT NULL DEFAULT 0 CHECK (puntos_canjeados >= 0),
    CONSTRAINT fk_pedido_cliente   FOREIGN KEY (id_cliente)   REFERENCES clientes(id_cliente),
    CONSTRAINT fk_pedido_direccion FOREIGN KEY (id_direccion) REFERENCES direcciones_cliente(id_direccion)
);

-- ============================================================
-- 14. LINEAS DE PEDIDO ONLINE
-- ============================================================
CREATE TABLE lineas_pedido (
    id_linea      INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido     INT NOT NULL,
    id_producto   INT NOT NULL,
    cantidad      INT NOT NULL CHECK (cantidad > 0),
    precio_unit   DECIMAL(10,2) NOT NULL CHECK (precio_unit >= 0),
    descuento_pct DECIMAL(5,2) NOT NULL DEFAULT 0 CHECK (descuento_pct >= 0 AND descuento_pct <= 100),
    CONSTRAINT fk_lp_pedido   FOREIGN KEY (id_pedido)   REFERENCES pedidos_online(id_pedido),
    CONSTRAINT fk_lp_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- 15. ENVIOS (un pedido puede generar varios envios parciales)
-- ============================================================
CREATE TABLE envios (
    id_envio              INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido             INT NOT NULL,
    id_sede_origen        INT NOT NULL,
    numero_seguimiento    VARCHAR(100),
    transportista         VARCHAR(100),
    fecha_estimada        DATE,
    fecha_entrega_real    DATE,
    estado                ENUM('preparando','en_transito','entregado','fallido') NOT NULL DEFAULT 'preparando',
    CONSTRAINT fk_envio_pedido FOREIGN KEY (id_pedido)      REFERENCES pedidos_online(id_pedido),
    CONSTRAINT fk_envio_sede   FOREIGN KEY (id_sede_origen) REFERENCES sedes(id_sede)
);

-- Lineas que van en cada envio (subconjunto de lineas_pedido)
CREATE TABLE envio_lineas (
    id_envio    INT NOT NULL,
    id_linea    INT NOT NULL,
    cantidad    INT NOT NULL CHECK (cantidad > 0),
    PRIMARY KEY (id_envio, id_linea),
    CONSTRAINT fk_el_envio FOREIGN KEY (id_envio) REFERENCES envios(id_envio),
    CONSTRAINT fk_el_linea FOREIGN KEY (id_linea) REFERENCES lineas_pedido(id_linea)
);

-- ============================================================
-- 16. VENTAS PRESENCIALES (ticket de tienda)
-- ============================================================
CREATE TABLE ventas_presenciales (
    id_venta      INT AUTO_INCREMENT PRIMARY KEY,
    id_sede       INT NOT NULL,
    id_empleado   INT NOT NULL,
    id_cliente    INT,          -- NULL si el cliente no esta registrado
    fecha_venta   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total         DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    CONSTRAINT fk_vp_sede     FOREIGN KEY (id_sede)     REFERENCES sedes(id_sede),
    CONSTRAINT fk_vp_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CONSTRAINT fk_vp_cliente  FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente)
);

-- ============================================================
-- 17. LINEAS DE VENTA PRESENCIAL
-- ============================================================
CREATE TABLE lineas_venta_presencial (
    id_linea_vp   INT AUTO_INCREMENT PRIMARY KEY,
    id_venta      INT NOT NULL,
    id_producto   INT NOT NULL,
    cantidad      INT NOT NULL CHECK (cantidad > 0),
    precio_unit   DECIMAL(10,2) NOT NULL CHECK (precio_unit >= 0),
    CONSTRAINT fk_lvp_venta   FOREIGN KEY (id_venta)    REFERENCES ventas_presenciales(id_venta),
    CONSTRAINT fk_lvp_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- 18. DEVOLUCIONES PRESENCIALES
-- ============================================================
CREATE TABLE devoluciones_presenciales (
    id_devolucion   INT AUTO_INCREMENT PRIMARY KEY,
    id_venta        INT NOT NULL,
    id_producto     INT NOT NULL,
    cantidad        INT NOT NULL CHECK (cantidad > 0),
    fecha           DATE NOT NULL,
    motivo          TEXT,
    CONSTRAINT fk_dp_venta    FOREIGN KEY (id_venta)    REFERENCES ventas_presenciales(id_venta),
    CONSTRAINT fk_dp_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- 19. TICKETS DE INCIDENCIA (atencion al cliente)
-- ============================================================
CREATE TABLE tickets_incidencia (
    id_ticket       INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT,          -- NULL si es consulta anonima
    id_pedido       INT,          -- NULL si no es sobre un pedido
    id_agente       INT NOT NULL,
    asunto          VARCHAR(255) NOT NULL,
    descripcion     TEXT,
    estado          ENUM('abierto','en_gestion','resuelto') NOT NULL DEFAULT 'abierto',
    fecha_apertura  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre    DATETIME,
    nota_resolucion TEXT,
    CONSTRAINT fk_ti_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ti_pedido  FOREIGN KEY (id_pedido)  REFERENCES pedidos_online(id_pedido),
    CONSTRAINT fk_ti_agente  FOREIGN KEY (id_agente)  REFERENCES empleados(id_empleado)
);

-- ============================================================
-- 20. VALORACIONES DE PRODUCTOS
-- ============================================================
CREATE TABLE valoraciones (
    id_valoracion  INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente     INT NOT NULL,
    id_producto    INT NOT NULL,
    puntuacion     TINYINT NOT NULL CHECK (puntuacion >= 1 AND puntuacion <= 5),
    comentario     TEXT,
    fecha          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verificada     TINYINT(1) NOT NULL DEFAULT 0,  -- 1 = compra confirmada
    UNIQUE KEY uq_val_cliente_producto (id_cliente, id_producto),
    CONSTRAINT fk_val_cliente  FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
    CONSTRAINT fk_val_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- 21. PROGRAMA DE FIDELIZACION — MOVIMIENTOS DE PUNTOS
-- ============================================================
CREATE TABLE movimientos_puntos (
    id_movimiento   INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT NOT NULL,
    id_pedido       INT,          -- NULL si el movimiento no viene de pedido
    tipo            ENUM('ganados','canjeados') NOT NULL,
    puntos          INT NOT NULL CHECK (puntos > 0),
    descripcion     VARCHAR(255),
    fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_mp_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_mp_pedido  FOREIGN KEY (id_pedido)  REFERENCES pedidos_online(id_pedido)
);

-- ============================================================
-- 22. VINCULACION CLIENTE ONLINE <-> VENTAS PRESENCIALES PREVIAS
--     Permite asociar historial presencial anonimo a cuenta registrada
-- ============================================================
CREATE TABLE vinculaciones_historial (
    id_vinculacion  INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT NOT NULL,
    id_venta        INT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    UNIQUE KEY uq_vin_cliente_venta (id_cliente, id_venta),
    CONSTRAINT fk_vh_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_vh_venta   FOREIGN KEY (id_venta)   REFERENCES ventas_presenciales(id_venta)
);

-- ============================================================
-- PRODUCTO <-> TIENDA FISICA (disponibilidad)
-- Un producto puede estar disponible en varias tiendas
-- ============================================================
CREATE TABLE producto_tienda (
    id_producto INT NOT NULL,
    id_sede     INT NOT NULL,
    disponible  TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id_producto, id_sede),
    CONSTRAINT fk_pt_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT fk_pt_sede     FOREIGN KEY (id_sede)     REFERENCES sedes(id_sede)
);
