
CREATE PROCEDURE [dbo].[Remitos_TX_DetalladoPorFechas]

@Desde datetime,
@Hasta datetime,
@IdObra int,
@CodigoSalida int,
@IdGrupoObra int

AS

SELECT 
 Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Numero],
 Obras.NumeroObra as [Obra],
 Articulos.Codigo as [Codigo],
 Unidades.Abreviatura as [Unidad],
 Articulos.Descripcion as [Descripcion],
 dr.Cantidad as [Cantidad],
 Null as [Med1],
 Null as [Med2],
 Articulos.CostoPPP,
 Articulos.CostoPPPDolar,
 Articulos.CostoReposicion,
 Articulos.CostoReposicionDolar
FROM DetalleRemitos dr
LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN Articulos ON dr.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON dr.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dr.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Obras ON Obras.IdObra=dr.IdObra
WHERE Remitos.FechaRemito>=@Desde and Remitos.FechaRemito<=@Hasta and 
	IsNull(Remitos.Anulado,'')<>'SI' and Remitos.Destino=@CodigoSalida and 
	(@IdObra=-1 or dr.IdObra=@IdObra) and (@IdGrupoObra=-1 or Obras.IdGrupoObra=@IdGrupoObra)
ORDER BY Articulos.Descripcion
