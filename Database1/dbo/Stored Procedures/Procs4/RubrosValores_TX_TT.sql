





























CREATE Procedure [dbo].[RubrosValores_TX_TT]
@IdRubroValor int
AS 
SELECT *
FROM RubrosValores
WHERE (IdRubroValor=@IdRubroValor)






























