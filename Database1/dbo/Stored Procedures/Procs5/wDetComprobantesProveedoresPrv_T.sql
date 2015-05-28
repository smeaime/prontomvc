
CREATE Procedure [dbo].[wDetComprobantesProveedoresPrv_T]
@IdDetalleComprobanteProveedorProvincias int=null
AS 
SELECT *
FROM [DetalleComprobantesProveedoresProvincias]
WHERE (IdDetalleComprobanteProveedorProvincias=@IdDetalleComprobanteProveedorProvincias)

