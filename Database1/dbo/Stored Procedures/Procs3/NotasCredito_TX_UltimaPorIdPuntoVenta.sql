


CREATE Procedure [dbo].[NotasCredito_TX_UltimaPorIdPuntoVenta]
@IdPuntoVenta int
AS 
SELECT Top 1 *
FROM NotasCredito
WHERE IdPuntoVenta=@IdPuntoVenta
ORDER BY FechaNotaCredito DESC


