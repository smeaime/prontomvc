CREATE Procedure [dbo].[DetClientesDirecciones_TXPrimero]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111133'
SET @vector_T='00311000'

SELECT TOP 1
 DetalleClientesDirecciones.IdDetalleClienteDireccion,
 DetalleClientesDirecciones.IdCliente,
 DetalleClientesDirecciones.Direccion as [Direccion],
 Localidades.Nombre as [Localidad],
 Provincias.Nombre as [Provincia],
 Paises.Descripcion as [Pais],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleClientesDirecciones
LEFT OUTER JOIN Localidades ON DetalleClientesDirecciones.IdLocalidad = Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON DetalleClientesDirecciones.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON DetalleClientesDirecciones.IdPais = Paises.IdPais