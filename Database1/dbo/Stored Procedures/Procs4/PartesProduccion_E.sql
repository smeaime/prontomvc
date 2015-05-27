CREATE Procedure [dbo].[PartesProduccion_E]

@IdParteProduccion int 

AS 

DELETE PartesProduccion
WHERE (IdParteProduccion=@IdParteProduccion)