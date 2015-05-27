



CREATE Procedure [dbo].[DetComprobantesProveedoresPrv_T]
@IdDetalleComprobanteProveedorProvincias int
AS 
SELECT *
FROM [DetalleComprobantesProveedoresProvincias]
WHERE (IdDetalleComprobanteProveedorProvincias=@IdDetalleComprobanteProveedorProvincias)




