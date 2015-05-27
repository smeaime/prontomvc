CREATE Procedure ProduccionTerminados_TX_Pendientes

AS 

SELECT ProduccionTerminados.*, Articulos.IdUnidad,  Articulos.Codigo,  Articulos.Descripcion as [DescripcionArt], Articulos.IdUbicacionStandar, Unidades.Abreviatura
FROM ProduccionTerminados
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=ProduccionTerminados.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Articulos.IdUnidad
WHERE ProduccionTerminados.IdDetalleRecepcion is null -- and IsNull(ProduccionTerminados.Cantidad,0)>0
ORDER BY ProduccionTerminados.NumeroOrdenProduccion