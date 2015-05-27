





























CREATE Procedure [dbo].[LMateriales_T]
@IdLMateriales int
AS 
SELECT * 
FROM LMateriales
WHERE (IdLMateriales=@IdLMateriales)






























