CREATE Procedure [dbo].[DetClientesDirecciones_M]

@IdDetalleClienteDireccion int,
@IdCliente int,
@Direccion varchar(50),
@IdLocalidad int,
@IdProvincia int,
@IdPais int

AS

UPDATE [DetalleClientesDirecciones]
SET 
 IdCliente=@IdCliente,
 Direccion=@Direccion,
 IdLocalidad=@IdLocalidad,
 IdProvincia=@IdProvincia,
 IdPais=@IdPais
WHERE (IdDetalleClienteDireccion=@IdDetalleClienteDireccion)

RETURN(@IdDetalleClienteDireccion)