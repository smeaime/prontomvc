





























CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesRes]
@IdDetalleLMateriales int
AS 
SELECT 
	SUM(DetRes.CantidadUnidades) as [Stock res.]
FROM DetalleReservas DetRes
WHERE DetRes.IdDetalleLMateriales =@IdDetalleLMateriales
GROUP BY DetRes.IdDetalleLMateriales






























