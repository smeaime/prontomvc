





























CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesVal]
@IdDetalleLMateriales int
AS 
SELECT 
	SUM(DetVal.Cantidad) as [Vales pedidos]
FROM DetalleValesSalida DetVal
WHERE DetVal.IdDetalleLMateriales =@IdDetalleLMateriales
GROUP BY DetVal.IdDetalleLMateriales






























