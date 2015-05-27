





















CREATE  Procedure [dbo].[LMateriales_TX_DesdeDetalle]
@IdDetalleLMateriales int
AS 
SELECT 
	LMateriales.IdLMateriales,
	LMateriales.NumeroLMateriales as [L.Materiales],
	DetalleLMateriales.NumeroItem as [Item]
FROM DetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales
WHERE (DetalleLMateriales.IdDetalleLMateriales=@IdDetalleLMateriales)





















