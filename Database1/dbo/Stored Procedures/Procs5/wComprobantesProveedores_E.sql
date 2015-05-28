
CREATE Procedure [dbo].[wComprobantesProveedores_E]
@IdComprobanteProveedor int
AS 
Delete ComprobantesProveedores
WHERE (IdComprobanteProveedor=@IdComprobanteProveedor)

