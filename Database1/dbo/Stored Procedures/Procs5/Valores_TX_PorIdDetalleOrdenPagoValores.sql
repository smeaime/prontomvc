
CREATE Procedure [dbo].[Valores_TX_PorIdDetalleOrdenPagoValores]
@IdDetalleOrdenPagoValores int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores
