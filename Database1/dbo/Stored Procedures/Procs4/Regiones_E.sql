CREATE Procedure [dbo].[Regiones_E]

@IdRegion int 

AS 

DELETE Regiones
WHERE (IdRegion=@IdRegion)