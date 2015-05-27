


CREATE Procedure [dbo].[Facturas_TX_UltimoAnteriorAFecha]
@FechaFactura datetime
AS 
SELECT Top 1 *
FROM Facturas
WHERE FechaFactura<=@FechaFactura and NumeroTicketFinal is not null
ORDER BY FechaFactura DESC,NumeroTicketFinal DESC


