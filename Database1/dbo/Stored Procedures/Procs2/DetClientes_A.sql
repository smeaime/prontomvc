CREATE Procedure [dbo].[DetClientes_A]

@IdDetalleCliente int  output,
@IdCliente int,
@Contacto varchar(50),
@Puesto varchar(50),
@Telefono varchar(50),
@Email varchar(200),
@Acciones varchar(500)

AS 

INSERT INTO [DetalleClientes]
(
 IdCliente,
 Contacto,
 Puesto,
 Telefono,
 Email,
 Acciones
)
VALUES
(
 @IdCliente,
 @Contacto,
 @Puesto,
 @Telefono,
 @Email,
 @Acciones
)

SELECT @IdDetalleCliente=@@identity

RETURN(@IdDetalleCliente)