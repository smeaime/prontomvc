CREATE PROCEDURE DetProduccionOrdenes_TX_PorIdConDatos2

@IdDetalleProduccionOrden int

AS 

SELECT Det.*, 
 Articulos.Codigo as Codigo,
 Articulos.Descripcion as Articulo,
 IsNull(Articulos.CostoReposicion,0) as CostoReposicion,
 Unidades.Descripcion as Unidad,
 IsNull((Select Sum(IsNull(dsm.Cantidad,0)) From DetalleSalidasMateriales dsm
	 Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales=dsm.IdSalidaMateriales
	 Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and dsm.IdDetalleProduccionOrden=Det.IdDetalleProduccionOrden),0) as [Salidas],
 Colores.Descripcion as [Color]
FROM dbo.DetalleProduccionOrdenes Det
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=Det.IdArticulo
LEFT OUTER JOIN Unidades  ON Unidades.IdUnidad=Det.IdUnidad
LEFT OUTER JOIN Colores  ON Colores.IdColor=Det.IdColor
WHERE (Det.IdDetalleProduccionOrden=@IdDetalleProduccionOrden)