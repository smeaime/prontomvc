CREATE Procedure [dbo].[Previsiones_E]

@IdPrevision int 

AS 

DELETE Previsiones
WHERE (IdPrevision=@IdPrevision)