CREATE Procedure [dbo].[DetProveedores_A]

@IdDetalleProveedor int  output,
@IdProveedor int,
@Contacto varchar(50),
@Puesto varchar(50),
@Telefono varchar(50),
@Email varchar(50),
@Acciones varchar(500)

AS 

INSERT INTO [DetalleProveedores]
(
 IdProveedor,
 Contacto,
 Puesto,
 Telefono,
 Email,
 Acciones
)
VALUES
(
 @IdProveedor,
 @Contacto,
 @Puesto,
 @Telefono,
 @Email,
 @Acciones
)

SELECT @IdDetalleProveedor=@@identity

RETURN(@IdDetalleProveedor)
