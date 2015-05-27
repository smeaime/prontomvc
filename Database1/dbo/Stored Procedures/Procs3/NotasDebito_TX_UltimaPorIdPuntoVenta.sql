


CREATE Procedure [dbo].[NotasDebito_TX_UltimaPorIdPuntoVenta]
@IdPuntoVenta int
AS 
SELECT Top 1 *
FROM NotasDebito
WHERE IdPuntoVenta=@IdPuntoVenta
ORDER BY FechaNotaDebito DESC


