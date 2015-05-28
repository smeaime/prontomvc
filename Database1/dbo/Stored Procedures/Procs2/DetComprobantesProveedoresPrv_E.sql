



CREATE Procedure [dbo].[DetComprobantesProveedoresPrv_E]
@IdDetalleComprobanteProveedorProvincias int  
AS 
DELETE [DetalleComprobantesProveedoresProvincias]
WHERE (IdDetalleComprobanteProveedorProvincias=@IdDetalleComprobanteProveedorProvincias)




