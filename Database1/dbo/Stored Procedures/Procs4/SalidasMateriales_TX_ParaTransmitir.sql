
CREATE PROCEDURE [dbo].[SalidasMateriales_TX_ParaTransmitir]

@IdObra int = Null

AS

SELECT 
 SalidasMateriales.IdSalidaMateriales,
 SalidasMateriales.NumeroSalidaMateriales2,
 SalidasMateriales.NumeroSalidaMateriales,
 SalidasMateriales.FechaSalidaMateriales,
 Det.IdDetalleSalidaMateriales,
 Det.IdArticulo,
 Det.Cantidad,
 Det.IdUnidad,
 Det.IdObra,
 Det.CostoUnitario,
 Det.IdMoneda,
 DetReq.IdDetalleRequerimientoOriginal,
 Det.Observaciones
FROM DetalleSalidasMateriales Det
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleValesSalida DetVal ON DetVal.IdDetalleValeSalida=Det.IdDetalleValeSalida
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetVal.IdDetalleRequerimiento
WHERE IsNull(Det.EnviarEmail,1)=1 and IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(IsNull(@IdObra,0)=0 or IsNull(@IdObra,0)=IsNull(Det.IdObra,-1))
