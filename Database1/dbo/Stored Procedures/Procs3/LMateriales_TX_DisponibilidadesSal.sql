


CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesSal]
@IdDetalleLMateriales int
AS 
SELECT SUM(DetSal.Cantidad) as [Vales entregados]
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida=DetalleValesSalida.IdDetalleValeSalida
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	DetalleValesSalida.IdDetalleLMateriales =@IdDetalleLMateriales
GROUP BY DetalleValesSalida.IdDetalleLMateriales


