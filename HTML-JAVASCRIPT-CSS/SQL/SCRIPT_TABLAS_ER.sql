-- --------------------------------------------------------------------
CREATE TABLE `categoria_producto`(
    `id_categoria_producto` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre_categoria` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id_categoria_producto`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `tipo_de_pago`(
    `id_tipo_de_pago` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre_tipo_de_pago` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id_tipo_de_pago`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `rol`(
    `id_rol` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre_rol` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id_rol`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `usuario`(
    `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(256) NOT NULL,
    `apellido` VARCHAR(256) NOT NULL,
    `nombre_usuario` VARCHAR(256) NOT NULL,
    `contraseña_usuario` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id_usuario`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `estado_pedido`(
    `id_estado_pedido` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre_estado_pedido` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id_estado_pedido`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `ubicacion_mesa`(
    `id_ubicacion_mesa` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre_ubicacion` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id_ubicacion_mesa`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `mesa`(
    `id_mesa` INT(11) NOT NULL AUTO_INCREMENT,
    `numero_mesa` INT(11) NOT NULL,
    `id_ubicacion_mesa` INT(11) NOT NULL,
    PRIMARY KEY(`id_mesa`),
    INDEX(`id_ubicacion_mesa`),
    CONSTRAINT `fk_ubicacion_mesa` FOREIGN KEY(`id_ubicacion_mesa`) REFERENCES `ubicacion_mesa`(`id_ubicacion_mesa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `pedido`(
    `id_pedido` INT(11) NOT NULL AUTO_INCREMENT,
    `id_mesa` INT(11) NOT NULL,
    `id_estado_pedido` INT(11) NOT NULL,
    `id_usuario` INT(11) NOT NULL,
    `fecha_hora` DATETIME NOT NULL,
    PRIMARY KEY(`id_pedido`),
    INDEX(`id_usuario`),
    INDEX(`id_mesa`),
    INDEX(`id_estado_pedido`),
    CONSTRAINT `fk_id_usuario` FOREIGN KEY(`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_id_mesa` FOREIGN KEY(`id_mesa`) REFERENCES `mesa`(`id_mesa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_id_estado_pedido` FOREIGN KEY(`id_estado_pedido`) REFERENCES `estado_pedido`(`id_estado_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `producto`(
    `id_producto` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre_producto` VARCHAR(256) NOT NULL,
    `precio` INT(11) NOT NULL,
    `detalles` TEXT NOT NULL,
    `id_categoria_producto` INT(11) NOT NULL,
    PRIMARY KEY(`id_producto`),
    INDEX(`id_categoria_producto`),
    CONSTRAINT `fk_id_categoria_producto` FOREIGN KEY(`id_categoria_producto`) REFERENCES `categoria_producto`(`id_categoria_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `producto_pedido`(
    `id_producto_pedido` INT(11) NOT NULL AUTO_INCREMENT,
    `id_estado_pedido` INT(11) NOT NULL,
    `id_pedido` INT(11) NOT NULL,
    `id_producto` INT(11) NOT NULL,
    PRIMARY KEY(`id_producto_pedido`),
    INDEX(`id_estado_pedido`),
    INDEX(`id_pedido`),
    INDEX(`id_producto`),
    CONSTRAINT `fk_id_estado_pedidos` FOREIGN KEY(`id_estado_pedido`) REFERENCES `estado_pedido`(`id_estado_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_id_pedido` FOREIGN KEY(`id_pedido`) REFERENCES `pedido`(`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_id_producto` FOREIGN KEY(`id_producto`) REFERENCES `producto`(`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `rol_usuario`(
    `id_rol_usuario` INT(11) NOT NULL AUTO_INCREMENT,
    `id_rol` INT(11) NOT NULL,
    `id_usuario` INT(11) NOT NULL,
    PRIMARY KEY(`id_rol_usuario`),
    INDEX(`id_rol`),
    INDEX(`id_usuario`),
    CONSTRAINT `fk_id_rol` FOREIGN KEY(`id_rol`) REFERENCES `rol`(`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_id_usuarios` FOREIGN KEY(`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------
CREATE TABLE `pago`(
    `id_pago` INT(11) NOT NULL AUTO_INCREMENT,
    `id_pedido` INT(11) NOT NULL,
    `id_tipo_de_pago` INT(11) NOT NULL,
    `fecha_hora` DATETIME NOT NULL,
    PRIMARY KEY(`id_pago`),
    INDEX(`id_tipo_de_pago`),
    INDEX(`id_pedido`),
    CONSTRAINT `fk_id_tipo_de_pago` FOREIGN KEY(`id_tipo_de_pago`) REFERENCES `tipo_de_pago`(`id_tipo_de_pago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_id_pedidos` FOREIGN KEY(`id_pedido`) REFERENCES `pedido`(`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
-- --------------------------------------------------------------------