





























CREATE Procedure [dbo].[LMateriales_TX_PorIdOrigenDetalleRevisiones]
@IdDetalleLMaterialesRevisionesOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 dlmr.IdDetalleLMaterialesRevisiones,LMateriales.IdLMateriales
FROM DetalleLMaterialesRevisiones dlmr 
LEFT OUTER JOIN LMateriales ON dlmr.IdLMateriales=LMateriales.IdLMateriales
WHERE dlmr.IdDetalleLMaterialesRevisionesOriginal=@IdDetalleLMaterialesRevisionesOriginal and 
	  dlmr.IdOrigenTransmision=@IdOrigenTransmision






























