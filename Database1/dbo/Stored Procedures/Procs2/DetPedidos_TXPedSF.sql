CREATE PROCEDURE [dbo].[DetPedidos_TXPedSF]

@IdPedido int

AS

SELECT *
FROM DetallePedidos
WHERE IdPedido = @IdPedido
ORDER by NumeroItem