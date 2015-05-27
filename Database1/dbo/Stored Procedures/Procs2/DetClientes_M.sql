CREATE Procedure [dbo].[DetClientes_M]

@IdDetalleCliente int,
@IdCliente int,
@Contacto varchar(50),
@Puesto varchar(50),
@Telefono varchar(50),
@Email varchar(200),
@Acciones varchar(500)

AS

UPDATE [DetalleClientes]
SET 
 IdCliente=@IdCliente,
 Contacto=@Contacto,
 Puesto=@Puesto,
 Telefono=@Telefono,
 Email=@Email,
 Acciones=@Acciones
WHERE (IdDetalleCliente=@IdDetalleCliente)

RETURN(@IdDetalleCliente)