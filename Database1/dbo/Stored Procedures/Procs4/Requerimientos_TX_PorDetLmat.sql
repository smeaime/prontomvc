






























CREATE  Procedure [dbo].[Requerimientos_TX_PorDetLmat]
@IdDetalleLMateriales int
AS 
SELECT 
DetLMat.IdDetalleLMateriales,
LMat.NumeroLMateriales,
DetLMat.NumeroItem
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
WHERE DetLMat.IdDetalleLMateriales=@IdDetalleLMateriales































