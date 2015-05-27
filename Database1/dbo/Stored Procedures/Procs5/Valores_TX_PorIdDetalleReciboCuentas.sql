















CREATE Procedure [dbo].[Valores_TX_PorIdDetalleReciboCuentas]
@IdDetalleReciboCuentas int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleReciboCuentas=@IdDetalleReciboCuentas
















