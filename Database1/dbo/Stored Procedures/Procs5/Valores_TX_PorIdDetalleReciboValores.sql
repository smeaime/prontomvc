















CREATE Procedure [dbo].[Valores_TX_PorIdDetalleReciboValores]
@IdDetalleReciboValores int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleReciboValores=@IdDetalleReciboValores















