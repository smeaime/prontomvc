
CREATE Procedure [dbo].[wDetComprobantesProveedoresPrv_E]
@IdDetalleComprobanteProveedorProvincias int  
AS 
DELETE [DetalleComprobantesProveedoresProvincias]
WHERE (IdDetalleComprobanteProveedorProvincias=@IdDetalleComprobanteProveedorProvincias)

