





























CREATE Procedure [dbo].[UnidadesOperativas_TX_TT]
@IdUnidadOperativa int
AS 
SELECT *
FROM UnidadesOperativas
WHERE (IdUnidadOperativa=@IdUnidadOperativa)






























