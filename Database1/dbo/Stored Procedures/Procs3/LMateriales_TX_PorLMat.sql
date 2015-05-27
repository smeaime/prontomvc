





























CREATE PROCEDURE [dbo].[LMateriales_TX_PorLMat]
@IdLMateriales int
AS 
SELECT *
FROM DetalleLMateriales
where (IdLMateriales=@IdLMateriales)






























