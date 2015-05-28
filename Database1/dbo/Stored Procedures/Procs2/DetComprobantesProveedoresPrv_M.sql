



CREATE Procedure [dbo].[DetComprobantesProveedoresPrv_M]
@IdDetalleComprobanteProveedorProvincias int,
@IdComprobanteProveedor int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
AS
UPDATE [DetalleComprobantesProveedoresProvincias]
SET 
 IdComprobanteProveedor=@IdComprobanteProveedor,
 IdProvinciaDestino=@IdProvinciaDestino,
 Porcentaje=@Porcentaje
WHERE (IdDetalleComprobanteProveedorProvincias=@IdDetalleComprobanteProveedorProvincias)
RETURN(@IdDetalleComprobanteProveedorProvincias)



