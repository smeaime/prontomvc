CREATE Procedure [dbo].[Acabados_E]

@IdAcabado int 

AS 

DELETE Acabados
WHERE (IdAcabado=@IdAcabado)