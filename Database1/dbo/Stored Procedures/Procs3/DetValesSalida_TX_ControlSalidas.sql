CREATE PROCEDURE DetValesSalida_TX_ControlSalidas

@IdDetalleValeSalida int,
@IdDetalleSalidaMateriales int = Null

AS 

SET @IdDetalleSalidaMateriales=IsNull(@IdDetalleSalidaMateriales,-1)

SELECT Det.Cantidad, 
 IsNull((Select Sum(IsNull(dsm.Cantidad,0)) From DetalleSalidasMateriales dsm
	 Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales=dsm.IdSalidaMateriales
	 Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and dsm.IdDetalleValeSalida=Det.IdDetalleValeSalida and dsm.IdDetalleSalidaMateriales<>@IdDetalleSalidaMateriales),0) as [Salidas]
FROM dbo.DetalleValesSalida Det
WHERE (IdDetalleValeSalida=@IdDetalleValeSalida)