
CREATE Procedure [dbo].[wDetComprobantesProveedoresPrv_A]
@IdDetalleComprobanteProveedorProvincias int output,
@IdComprobanteProveedor int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
As 

IF IsNull(@IdDetalleComprobanteProveedorProvincias,0)<=0
    BEGIN 

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
	END
 ELSE
	BEGIN
		UPDATE [DetalleComprobantesProveedoresProvincias]
		SET 
		 IdComprobanteProveedor=@IdComprobanteProveedor,
		 IdProvinciaDestino=@IdProvinciaDestino,
		 Porcentaje=@Porcentaje
		WHERE (IdDetalleComprobanteProveedorProvincias=@IdDetalleComprobanteProveedorProvincias)
	 END

Return(@IdDetalleComprobanteProveedorProvincias)

