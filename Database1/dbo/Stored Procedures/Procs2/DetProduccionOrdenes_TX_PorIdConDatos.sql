
CREATE PROCEDURE [dbo].[DetProduccionOrdenes_TX_PorIdConDatos]

@IdProduccionOrden int

AS 

SELECT Det.*, 
 Articulos.Codigo as Codigo,
 Articulos.Descripcion as Articulo,
 IsNull(Articulos.CostoReposicion,0) as CostoReposicion,
 Unidades.Descripcion as Unidad,
 isnull(dbo.fProduccionAvanzadoMaterial(DET.IdProduccionOrden,DET.IdArticulo,DET.idcolor),0) as [Avance],
 rtrim(dbo.fProduccionPartidaParte(DET.IdProduccionOrden,DET.IdArticulo,DET.idcolor)) as Partida, 
 100/ (isnull(Det.Cantidad,0)+0.001)  * (isnull(dbo.fProduccionAvanzadoMaterial(DET.IdProduccionOrden,DET.IdArticulo,DET.idcolor),0))   as Porcentaje,
 IsNull((Select Sum(IsNull(dsm.Cantidad,0)) From DetalleSalidasMateriales dsm
	 Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales=dsm.IdSalidaMateriales
	 Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and dsm.IdDetalleProduccionOrden=Det.IdDetalleProduccionOrden),0) as [Salidas]
FROM dbo.DetalleProduccionOrdenes Det
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=Det.IdArticulo
LEFT OUTER JOIN Unidades  ON Unidades.IdUnidad=Det.IdUnidad
WHERE (IdProduccionOrden=@IdProduccionOrden)
