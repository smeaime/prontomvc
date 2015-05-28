CREATE Procedure [dbo].[DetComprobantesProveedores_T]

@IdDetalleComprobanteProveedor int

AS 

SELECT *
FROM DetalleComprobantesProveedores
WHERE (IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedor)