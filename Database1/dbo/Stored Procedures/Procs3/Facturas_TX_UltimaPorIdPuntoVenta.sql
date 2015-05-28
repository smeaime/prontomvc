


CREATE Procedure [dbo].[Facturas_TX_UltimaPorIdPuntoVenta]
@IdPuntoVenta int
AS 
SELECT Top 1 *
FROM Facturas
WHERE IdPuntoVenta=@IdPuntoVenta
ORDER BY FechaFactura DESC


