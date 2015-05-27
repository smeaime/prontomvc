



CREATE Procedure [dbo].[DetComprobantesProveedoresPrv_A]
@IdDetalleComprobanteProveedorProvincias int output,
@IdComprobanteProveedor int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
As 
Insert into [DetalleComprobantesProveedoresProvincias]
(
 IdComprobanteProveedor,
 IdProvinciaDestino,
 Porcentaje
)
Values
(
 @IdComprobanteProveedor,
 @IdProvinciaDestino,
 @Porcentaje
)
Select @IdDetalleComprobanteProveedorProvincias=@@identity
Return(@IdDetalleComprobanteProveedorProvincias)



