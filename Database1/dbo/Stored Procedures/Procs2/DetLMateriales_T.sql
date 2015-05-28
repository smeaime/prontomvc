





























CREATE Procedure [dbo].[DetLMateriales_T]
@IdDetalleLMateriales int
AS 
SELECT *
FROM [DetalleLMateriales]
where (IdDetalleLMateriales=@IdDetalleLMateriales)






























