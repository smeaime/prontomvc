
CREATE Procedure [dbo].[wDetComprobantesProveedores_E]
@IdDetalleComprobanteProveedores int
AS 
Delete DetalleComprobantesProveedores
WHERE (IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedores)

