





























CREATE Procedure [dbo].[LMateriales_TX_PorIdOrigenDetalle]
@IdDetalleLMaterialesOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 dlm.IdDetalleLMateriales,LMateriales.IdLMateriales
FROM DetalleLMateriales dlm
LEFT OUTER JOIN LMateriales ON dlm.IdLMateriales=LMateriales.IdLMateriales
WHERE dlm.IdDetalleLMaterialesOriginal=@IdDetalleLMaterialesOriginal and 
	  dlm.IdOrigenTransmision=@IdOrigenTransmision






























