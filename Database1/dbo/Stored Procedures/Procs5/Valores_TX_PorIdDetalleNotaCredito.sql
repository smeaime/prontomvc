




CREATE Procedure [dbo].[Valores_TX_PorIdDetalleNotaCredito]
@IdDetalleNotaCredito int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleNotaCredito=@IdDetalleNotaCredito





