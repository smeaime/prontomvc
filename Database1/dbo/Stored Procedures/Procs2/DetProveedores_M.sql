CREATE Procedure [dbo].[DetProveedores_M]

@IdDetalleProveedor int,
@IdProveedor int,
@Contacto varchar(50),
@Puesto varchar(50),
@Telefono varchar(50),
@Email varchar(50),
@Acciones varchar(500)

AS

UPDATE [DetalleProveedores]
SET 
 IdProveedor=@IdProveedor,
 Contacto=@Contacto,
 Puesto=@Puesto,
 Telefono=@Telefono,
 Email=@Email,
 Acciones=@Acciones
WHERE (IdDetalleProveedor=@IdDetalleProveedor)

RETURN(@IdDetalleProveedor)
