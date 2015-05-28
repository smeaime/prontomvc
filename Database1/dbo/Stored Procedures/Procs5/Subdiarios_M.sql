


CREATE Procedure [dbo].[Subdiarios_M]

@IdSubdiario int,
@Ejercicio int,
@IdCuentaSubdiario int,
@IdCuenta int,
@IdTipoComprobante int,
@NumeroComprobante int,
@FechaComprobante datetime,
@Detalle varchar(100),
@Debe numeric(18,2),
@Haber numeric(18,2),
@IdComprobante int,
@IdMoneda int,
@CotizacionMoneda numeric(18,4),
@REP_IMPUTAC_INS varchar(1),
@REP_IMPUTAC_UPD varchar(1),
@IdDetalleComprobante int,
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdSubdiarioOriginal int,
@FechaImportacionTransmision datetime,
@IdComprobanteOriginal int

As
Update Subdiarios

Set 

 Ejercicio=@Ejercicio,
 IdCuentaSubdiario=@IdCuentaSubdiario,
 IdCuenta=@IdCuenta,
 IdTipoComprobante=@IdTipoComprobante,
 NumeroComprobante=@NumeroComprobante,
 FechaComprobante=@FechaComprobante,
 Detalle=@Detalle,
 Debe=@Debe,
 Haber=@Haber,
 IdComprobante=@IdComprobante,
 IdMoneda=@IdMoneda,
 CotizacionMoneda=@CotizacionMoneda,
 IdDetalleComprobante=@IdDetalleComprobante,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdSubdiarioOriginal=@IdSubdiarioOriginal,
 FechaImportacionTransmision=@FechaImportacionTransmision,
 IdComprobanteOriginal=@IdComprobanteOriginal

Where (IdSubdiario=@IdSubdiario)
Return(@IdSubdiario)


