
























CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleComprobanteProveedor]
@IdDetalleComprobanteProveedor int
AS 
DELETE FROM Valores
WHERE (IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedor)

























