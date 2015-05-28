
























CREATE Procedure [dbo].[Valores_TX_PorIdDetalleComprobanteProveedor]
@IdDetalleComprobanteProveedor int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedor

























