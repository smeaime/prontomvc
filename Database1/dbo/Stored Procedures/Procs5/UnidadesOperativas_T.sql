





























CREATE Procedure [dbo].[UnidadesOperativas_T]
@IdUnidadOperativa int
AS 
SELECT *
FROM UnidadesOperativas
WHERE (IdUnidadOperativa=@IdUnidadOperativa)






























