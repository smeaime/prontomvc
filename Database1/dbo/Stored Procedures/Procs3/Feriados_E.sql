CREATE Procedure [dbo].[Feriados_E]

@IdFeriado int  

AS 

DELETE Feriados
WHERE (IdFeriado=@IdFeriado)