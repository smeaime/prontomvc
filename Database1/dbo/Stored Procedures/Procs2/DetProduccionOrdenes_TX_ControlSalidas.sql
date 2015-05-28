CREATE PROCEDURE DetProduccionOrdenes_TX_ControlSalidas

@IdDetalleProduccionOrden int,
@IdDetalleSalidaMateriales int = Null

AS 

SET @IdDetalleSalidaMateriales=IsNull(@IdDetalleSalidaMateriales,-1)

SELECT Det.Cantidad, 
 IsNull((Select Sum(IsNull(dsm.Cantidad,0)) From DetalleSalidasMateriales dsm
	 Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales=dsm.IdSalidaMateriales
	 Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and dsm.IdDetalleProduccionOrden=Det.IdDetalleProduccionOrden and dsm.IdDetalleSalidaMateriales<>@IdDetalleSalidaMateriales),0) as [Salidas]
FROM dbo.DetalleProduccionOrdenes Det
WHERE (IdDetalleProduccionOrden=@IdDetalleProduccionOrden)