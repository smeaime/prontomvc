CREATE Procedure [dbo].[Clientes_TX_LugaresEntrega]

@IdCliente int,
@IdDetalleClienteLugarEntrega int = Null

AS 

SET @IdDetalleClienteLugarEntrega=IsNull(@IdDetalleClienteLugarEntrega,-1)

SELECT
 0 as [IdDetalleClienteLugarEntrega],
 IsNull(Clientes.DireccionEntrega+' ','')+IsNull(Localidades.Nombre COLLATE Modern_Spanish_CI_AS+' ','')+IsNull(Provincias.Nombre COLLATE Modern_Spanish_CI_AS+' ','') as [Titulo]
FROM Clientes
LEFT OUTER JOIN Localidades ON Clientes.IdLocalidadEntrega = Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON Clientes.IdProvinciaEntrega = Provincias.IdProvincia
WHERE @IdDetalleClienteLugarEntrega<=0 and Clientes.IdCliente = @IdCliente

UNION ALL

SELECT
 Det.IdDetalleClienteLugarEntrega as [IdDetalleClienteLugarEntrega],
 IsNull(Det.DireccionEntrega+' ','')+IsNull(Localidades.Nombre COLLATE Modern_Spanish_CI_AS+' ','')+IsNull(Provincias.Nombre COLLATE Modern_Spanish_CI_AS+' ','') as [Titulo]
FROM DetalleClientesLugaresEntrega Det
LEFT OUTER JOIN Localidades ON Det.IdLocalidadEntrega = Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON Det.IdProvinciaEntrega = Provincias.IdProvincia
WHERE Det.IdCliente = @IdCliente and (@IdDetalleClienteLugarEntrega=-1 or Det.IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega)