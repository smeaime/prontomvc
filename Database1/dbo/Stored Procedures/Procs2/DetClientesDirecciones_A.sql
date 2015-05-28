CREATE Procedure [dbo].[DetClientesDirecciones_A]

@IdDetalleClienteDireccion int  output,
@IdCliente int,
@Direccion varchar(50),
@IdLocalidad int,
@IdProvincia int,
@IdPais int

AS 

INSERT INTO [DetalleClientesDirecciones]
(
 IdCliente,
 Direccion,
 IdLocalidad,
 IdProvincia,
 IdPais
)
VALUES
(
 @IdCliente,
 @Direccion,
 @IdLocalidad,
 @IdProvincia,
 @IdPais
)

SELECT @IdDetalleClienteDireccion=@@identity
RETURN(@IdDetalleClienteDireccion)