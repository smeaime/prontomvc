CREATE Procedure [dbo].[Valores_TX_PorId]

@IdValor int

AS 

SELECT *
FROM Valores
WHERE (IdValor=@IdValor)