





























CREATE Procedure [dbo].[LMateriales_TX_DetallesAReservar]
@IdArticulo int
AS 
SELECT 
DetLM.IdDetalleLMateriales,
'[ LM ] : '+str(LMateriales.NumeroLMateriales)+'  [ Item ] : '+str(DetLM.NumeroItem)+'  [ Obra ] : '+Obras.NumeroObra+'  [ Cant] : '+str(DetLM.Cantidad) as [Titulo]
FROM DetalleLMateriales DetLM
INNER JOIN LMateriales ON DetLM.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Obras ON LMateriales.IdObra=Obras.IdObra
WHERE DetLM.IdArticulo=@IdArticulo
ORDER BY Titulo






























