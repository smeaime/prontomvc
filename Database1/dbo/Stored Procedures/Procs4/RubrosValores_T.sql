





























CREATE Procedure [dbo].[RubrosValores_T]
@IdRubroValor int
AS 
SELECT *
FROM RubrosValores
WHERE (IdRubroValor=@IdRubroValor)






























