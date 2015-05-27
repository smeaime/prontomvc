




CREATE Procedure [dbo].[Valores_TX_PorIdDetalleNotaDebito]
@IdDetalleNotaDebito int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleNotaDebito=@IdDetalleNotaDebito





