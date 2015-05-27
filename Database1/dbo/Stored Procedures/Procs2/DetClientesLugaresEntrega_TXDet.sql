CREATE Procedure [dbo].[DetClientesLugaresEntrega_TXDet]

@IdCliente int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0011133'
SET @vector_T='0033300'

SELECT
 DetalleClientesLugaresEntrega.IdDetalleClienteLugarEntrega,
 DetalleClientesLugaresEntrega.IdCliente,
 DetalleClientesLugaresEntrega.DireccionEntrega as [Direccion],
 Localidades.Nombre as [Localidad],
 Provincias.Nombre as [Provincia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleClientesLugaresEntrega
LEFT OUTER JOIN Localidades ON DetalleClientesLugaresEntrega.IdLocalidadEntrega = Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON DetalleClientesLugaresEntrega.IdProvinciaEntrega = Provincias.IdProvincia
WHERE (DetalleClientesLugaresEntrega.IdCliente = @IdCliente)