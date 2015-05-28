





























CREATE Procedure [dbo].[LMateriales_ActualizarDetalles]
@IdLMaterialesOriginal int,
@IdOrigenTransmision int
as
Update DetalleLMateriales
SET 
IdLMateriales=(Select Top 1 LMat.IdLMateriales From LMateriales LMat 
		Where 	LMat.IdLMaterialesOriginal=@IdLMaterialesOriginal and 
			LMat.IdOrigenTransmision=@IdOrigenTransmision)
Where 	IdLMaterialesOriginal=@IdLMaterialesOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
Update DetalleLMaterialesRevisiones 
SET 
IdLMateriales=(Select Top 1 LMat.IdLMateriales From LMateriales LMat 
		Where 	LMat.IdLMaterialesOriginal=@IdLMaterialesOriginal and 
			LMat.IdOrigenTransmision=@IdOrigenTransmision)
Where 	IdLMaterialesOriginal=@IdLMaterialesOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision






























