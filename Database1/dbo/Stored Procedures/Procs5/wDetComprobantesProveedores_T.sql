
CREATE Procedure [dbo].[wDetComprobantesProveedores_T]
@IdDetalleComprobanteProveedor int=null
AS 
SELECT *
FROM DetalleComprobantesProveedores
WHERE (IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedor)

