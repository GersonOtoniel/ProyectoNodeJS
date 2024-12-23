CREATE DATABASE GDA00386OTGersonGonzalez;

CREATE TABLE rol (
	nombre VARCHAR(45) NOT NULL,
	idrol INT PRIMARY KEY
);

CREATE TABLE estados (
	idestados INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(45) NOT NULL
);

CREATE TABLE Clientes (
	idClientes INT IDENTITY PRIMARY KEY,
	razon_social VARCHAR(245),
	nombre_comercial VARCHAR(345),
	direccion_entrega VARCHAR(45) NOT NULL CHECK (direccion_entrega <> ''),
	telefono VARCHAR(45) NOT NULL,
	email VARCHAR(45) UNIQUE CHECK (email LIKE '%_@__%.__%')

);

CREATE TABLE usuarios (
	idusuarios INT IDENTITY PRIMARY KEY,
	rol_idrol INT NOT NULL,
	estados_idestados INT NOT NULL,
	correo_electronico VARCHAR(45),
	nombre_completo VARCHAR(45) NOT NULL,
	password VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	fecha_nacimiento DATE,
	fecha_creacion DATETIME,
	FOREIGN KEY (rol_idrol) REFERENCES rol(idrol),
	FOREIGN KEY (estados_idestados) REFERENCES estados(idestados)
);

CREATE TABLE usuarios_clientes(
	idusuarios INT NOT NULL,
	idClientes INT NOT NULL,
	fecha_asociada DATETIME NOT NULL,
	PRIMARY KEY (idusuarios, idClientes),
	FOREIGN KEY (idusuarios) REFERENCES usuarios(idusuarios),
	FOREIGN KEY (idClientes) REFERENCES Clientes(idClientes)
);

CREATE TABLE CategoriaProductos (
	idCategoriaProductos INT IDENTITY PRIMARY KEY,
	usuarios_idusuarios INT NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	estados_idestados INT NOT NULL,
	fecha_creacion DATETIME,
	FOREIGN KEY (usuarios_idusuarios) REFERENCES usuarios(idusuarios),
    FOREIGN KEY (estados_idestados) REFERENCES estados(idestados)
);

CREATE TABLE Productos (
	idProductos INT IDENTITY PRIMARY KEY,
	CategoriaProductos_idCategoriaProductos INT NOT NULL,
	usuarios_idusuarios INT,
	nombre VARCHAR(45) NOT NULL,
	marca VARCHAR(45),
	codigo VARCHAR(45) NOT NULL,
	stock FLOAT,
	estados_idestados INT NOT NULL,
	precio FLOAT NOT NULL,
	fecha_creacion DATETIME,
	foto VARBINARY(MAX),
	FOREIGN KEY (CategoriaProductos_idCategoriaProductos) REFERENCES CategoriaProductos(idCategoriaProductos),
    FOREIGN KEY (usuarios_idusuarios) REFERENCES usuarios(idusuarios),
    FOREIGN KEY (estados_idestados) REFERENCES estados(idestados)
);

--Se agrego idClientes para llevar el contro de ordenes por cliente
CREATE TABLE Orden (
	idOrden INT IDENTITY PRIMARY KEY,
	usuarios_idusuarios INT NOT NULL,
	estados_idestados INT NOT NULL,
	fecha_creacion DATETIME,
	nombre_completo VARCHAR(100) NOT NULL,
	direccion VARCHAR(545) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	correo_electronico VARCHAR(100),
	fecha_entrega DATE NOT NULL,
	total_orden FLOAT NOT NULL,
	Clientes_idClientes INT NOT NULL,
	FOREIGN KEY (usuarios_idusuarios) REFERENCES usuarios(idusuarios),
    FOREIGN KEY (estados_idestados) REFERENCES estados(idestados),
	FOREIGN KEY (Clientes_idClientes) REFERENCES Clientes(idClientes)
);

CREATE TABLE OrdenDetalles (
	idOrdenDetalles INT IDENTITY PRIMARY KEY,
	Orden_idOrden INT NOT NULL,
	Productos_idProductos INT NOT NULL,
	cantidad INT NOT NULL,
	precio FLOAT NOT NULL,
	subtotal FLOAT NOT NULL,
	FOREIGN KEY (Orden_idOrden) REFERENCES Orden(idOrden),
    FOREIGN KEY (Productos_idProductos) REFERENCES Productos(idProductos)
);


--Insercion de datos
INSERT INTO Clientes (razon_social, nombre_comercial, direccion_entrega, telefono, email)
VALUES
('Empresa A S.A.', 'Comercial A', 'Calle 1, Zona 1', '555-1111', 'contacto@empresaA.com')

INSERT INTO Orden (usuarios_idusuarios, estados_idestados, fecha_creacion, nombre_completo, direccion, telefono, correo_electronico, fecha_entrega, total_orden, Clientes_idClientes)
VALUES
(1, 1, '2024-08-01', 'Juan Pérez', 'Dirección 18 calle zona 1', '55555555', 'juan.perez@gmail.com', '2024-08-03', 200.50, 1)

INSERT INTO OrdenDetalles (Orden_idOrden, Productos_idProductos, cantidad, precio, subtotal)
VALUES
(1, 1, 2, 50.25, 122.45)

INSERT INTO Productos (CategoriaProductos_idCategoriaProductos, usuarios_idusuarios, nombre, marca, codigo, stock, estados_idestados, precio, fecha_creacion, foto)
VALUES
(1, 1, 'Azucar', 'Marca caña Real', 'COD123', 50, 1, 25.00, '2024-08-01', NULL)

INSERT INTO usuarios (rol_idrol, estados_idestados, correo_electronico, nombre_completo, password, telefono, fecha_nacimiento, fecha_creacion)
VALUES
(1, 1, 'juan.perez@gmail.com', 'Juan Pérez', 'password123', '55555555', '1995-03-04', '2024-08-01', 1)


--Creacion de procedimientos
GO
CREATE PROC InsertarCliente (
    @razon_social VARCHAR(245),
    @nombre_comercial VARCHAR(345),
    @direccion_entrega VARCHAR(45),
    @telefono VARCHAR(45),
    @email VARCHAR(45)
)
AS
BEGIN
    INSERT INTO Clientes (razon_social, nombre_comercial, direccion_entrega, telefono, email)
    VALUES (@razon_social, @nombre_comercial, @direccion_entrega, @telefono, @email);
END;

GO
CREATE PROC InsertarOrden (
    @usuarios_idusuarios INT,
    @estados_idestados INT,
    @fecha_creacion DATETIME,
    @nombre_completo VARCHAR(45),
    @direccion VARCHAR(545),
    @telefono VARCHAR(45),
    @correo_electronico VARCHAR(45),
    @fecha_entrega DATE,
    @total_orden FLOAT,
    @Clientes_idClientes INT
)
AS
BEGIN
    INSERT INTO Orden (
        usuarios_idusuarios, estados_idestados, fecha_creacion, nombre_completo,
        direccion, telefono, correo_electronico, fecha_entrega, total_orden, Clientes_idClientes
    )
    VALUES (
        @usuarios_idusuarios, @estados_idestados, @fecha_creacion, @nombre_completo,
        @direccion, @telefono, @correo_electronico, @fecha_entrega, @total_orden, @Clientes_idClientes
    );
END;

GO
CREATE PROC InsertarOrdenDetalle (
    @Orden_idOrden INT,
    @Productos_idProductos INT,
    @cantidad INT,
    @precio FLOAT,
    @subtotal FLOAT
)
AS
BEGIN
    INSERT INTO OrdenDetalles (Orden_idOrden, Productos_idProductos, cantidad, precio, subtotal)
    VALUES (@Orden_idOrden, @Productos_idProductos, @cantidad, @precio, @subtotal);
END;

GO
CREATE PROC InsertarProducto (
    @CategoriaProductos_idCategoriaProductos INT,
    @usuarios_idusuarios INT,
    @nombre VARCHAR(45),
    @marca VARCHAR(45),
    @codigo VARCHAR(45),
    @stock FLOAT,
    @estados_idestados INT,
    @precio FLOAT,
    @fecha_creacion DATETIME,
    @foto VARBINARY(MAX)
)
AS
BEGIN
    INSERT INTO Productos (CategoriaProductos_idCategoriaProductos, usuarios_idusuarios, nombre, marca, codigo, stock, estados_idestados, precio, fecha_creacion, foto)
    VALUES (@CategoriaProductos_idCategoriaProductos, @usuarios_idusuarios, @nombre, @marca, @codigo, @stock, @estados_idestados, @precio, @fecha_creacion, @foto);
END;

GO
CREATE PROC InsertarUsuario (
    @rol_idrol INT,                
    @estados_idestados INT,        
    @correo_electronico VARCHAR(45),
    @nombre_completo VARCHAR(45),
    @password VARCHAR(45),
    @telefono VARCHAR(45),
    @fecha_nacimiento DATE,
    @fecha_creacion DATETIME      
)
AS
BEGIN
    
    INSERT INTO usuarios (
        rol_idrol, estados_idestados, correo_electronico, nombre_completo, 
        password, telefono, fecha_nacimiento, fecha_creacion
    )
    VALUES (
        @rol_idrol, @estados_idestados, @correo_electronico, @nombre_completo, 
        @password, @telefono, @fecha_nacimiento, @fecha_creacion
    );
END;

GO
CREATE PROC ActualizarCliente (
    @idClientes INT,
    @razon_social VARCHAR(245),
    @nombre_comercial VARCHAR(345),
    @direccion_entrega VARCHAR(45),
    @telefono VARCHAR(45),
    @email VARCHAR(45)
)
AS
BEGIN
    UPDATE Clientes
    SET
        razon_social = @razon_social,
        nombre_comercial = @nombre_comercial,
        direccion_entrega = @direccion_entrega,
        telefono = @telefono,
        email = @email
    WHERE idClientes = @idClientes;
END;

GO
CREATE PROC ActualizarOrden (
    @idOrden INT,
    @usuarios_idusuarios INT,
    @estados_idestados INT,
    @fecha_creacion DATETIME,
    @nombre_completo VARCHAR(45),
    @direccion VARCHAR(545),
    @telefono VARCHAR(45),
    @correo_electronico VARCHAR(45),
    @fecha_entrega DATE,
    @total_orden FLOAT,
    @Clientes_idClientes INT
)
AS
BEGIN
    UPDATE Orden
    SET
        usuarios_idusuarios = @usuarios_idusuarios,
        estados_idestados = @estados_idestados,
        fecha_creacion = @fecha_creacion,
        nombre_completo = @nombre_completo,
        direccion = @direccion,
        telefono = @telefono,
        correo_electronico = @correo_electronico,
        fecha_entrega = @fecha_entrega,
        total_orden = @total_orden,
        Clientes_idClientes = @Clientes_idClientes
    WHERE idOrden = @idOrden;
END;

GO
CREATE PROC ActualizarOrdenDetalle (
    @idOrdenDetalles INT,
    @Orden_idOrden INT,
    @Productos_idProductos INT,
    @cantidad INT,
    @precio FLOAT,
    @subtotal FLOAT
)
AS
BEGIN
    UPDATE OrdenDetalles
    SET
        Orden_idOrden = @Orden_idOrden,
        Productos_idProductos = @Productos_idProductos,
        cantidad = @cantidad,
        precio = @precio,
        subtotal = @subtotal
    WHERE idOrdenDetalles = @idOrdenDetalles;
END;

GO
CREATE PROC ActualizarProducto (
    @idProductos INT,
    @CategoriaProductos_idCategoriaProductos INT,
    @usuarios_idusuarios INT,
    @nombre VARCHAR(45),
    @marca VARCHAR(45),
    @codigo VARCHAR(45),
    @stock FLOAT,
    @estados_idestados INT,
    @precio FLOAT,
    @fecha_creacion DATETIME,
    @foto VARBINARY(MAX)
)
AS
BEGIN
    UPDATE Productos
    SET
        CategoriaProductos_idCategoriaProductos = @CategoriaProductos_idCategoriaProductos,
        usuarios_idusuarios = @usuarios_idusuarios,
        nombre = @nombre,
        marca = @marca,
        codigo = @codigo,
        stock = @stock,
        estados_idestados = @estados_idestados,
        precio = @precio,
        fecha_creacion = @fecha_creacion,
        foto = @foto
    WHERE idProductos = @idProductos;
END;


GO
CREATE PROCEDURE InsertarOrdenCompleta
    @p_idCliente INT,
    @p_total DECIMAL(10, 2),
    @p_fecha_creacion DATE,
    @p_detalles NVARCHAR(MAX) -- Lista de detalles en formato JSON
AS
BEGIN
    -- Declarar variables
    DECLARE @idOrden INT;

    -- Iniciar transacción
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insertar la orden
        INSERT INTO Orden (Clientes_idClientes, total_orden, fecha_creacion)
        VALUES (@p_idCliente, @p_total, @p_fecha_creacion);

        -- Obtener el ID de la orden recién creada
        SET @idOrden = SCOPE_IDENTITY();  -- Usar SCOPE_IDENTITY() para obtener el ID generado

        -- Insertar los detalles de la orden
        -- Usar OPENJSON para descomponer el JSON y obtener los datos de cada detalle
        INSERT INTO OrdenDetalles(idOrden, idProducto, cantidad, precio)
        SELECT 
            @idOrden, 
            JSON_VALUE(Detalle.value, '$.idProducto') AS idProducto,
            JSON_VALUE(Detalle.value, '$.cantidad') AS cantidad,
            JSON_VALUE(Detalle.value, '$.precio') AS precio
        FROM OPENJSON(@p_detalles) AS Detalle;

        -- Confirmar la transacción
        COMMIT;
    END TRY
    BEGIN CATCH
        -- En caso de error, revertir la transacción
        ROLLBACK;
        -- Opcional: Manejar el error (se puede capturar el error con ERROR_MESSAGE(), ERROR_NUMBER(), etc.)
        THROW;
    END CATCH;
END;





-- Consultas como Vistas
-- estado configurado como 1 activo 0 inactivo
GO
CREATE VIEW ProductosActivosStock AS
SELECT * 
FROM Productos
WHERE estados_idestados = 1 AND stock > 0;

GO
CREATE VIEW TotalVentasAgosto2024 AS
SELECT SUM(total_orden) AS TotalVentas
FROM Orden
WHERE MONTH(fecha_creacion) = 8 AND YEAR(fecha_creacion) = 2024;

GO
CREATE VIEW TopClientesConsumo AS
SELECT TOP 10 
    Clientes_idClientes, 
    COUNT(idOrden) AS CantidadOrdenes
FROM Orden
GROUP BY Clientes_idClientes
ORDER BY CantidadOrdenes DESC;


GO
CREATE VIEW TopProductosVendidos AS
SELECT TOP 10 Productos_idProductos, SUM(cantidad) AS TotalVendido
FROM OrdenDetalles
GROUP BY Productos_idProductos
ORDER BY TotalVendido ASC;

