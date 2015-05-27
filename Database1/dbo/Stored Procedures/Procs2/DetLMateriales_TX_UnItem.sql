





























CREATE Procedure [dbo].[DetLMateriales_TX_UnItem]
@IdDetalleLMateriales int
AS 
SELECT *
FROM [DetalleLMateriales]
where (IdDetalleLMateriales=@IdDetalleLMateriales)






























