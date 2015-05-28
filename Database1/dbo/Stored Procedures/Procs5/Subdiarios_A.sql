CREATE Procedure [dbo].[Subdiarios_A]

@IdSubdiario int  output,
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

AS

INSERT INTO [Subdiarios]
(
 Ejercicio,
 IdCuentaSubdiario,
 IdCuenta,
 IdTipoComprobante,
 NumeroComprobante,
 FechaComprobante,
 Detalle,
 Debe,
 Haber,
 IdComprobante,
 IdMoneda,
 CotizacionMoneda,
 REP_IMPUTAC_INS,
 REP_IMPUTAC_UPD,
 IdDetalleComprobante,
 EnviarEmail,
 IdOrigenTransmision,
 IdSubdiarioOriginal,
 FechaImportacionTransmision,
 IdComprobanteOriginal
)
VALUES
(
 @Ejercicio,
 @IdCuentaSubdiario,
 @IdCuenta,
 @IdTipoComprobante,
 @NumeroComprobante,
 @FechaComprobante,
 @Detalle,
 @Debe,
 @Haber,
 @IdComprobante,
 @IdMoneda,
 @CotizacionMoneda,
 @REP_IMPUTAC_INS,
 @REP_IMPUTAC_UPD,
 @IdDetalleComprobante,
 @EnviarEmail,
 @IdOrigenTransmision,
 @IdSubdiarioOriginal,
 @FechaImportacionTransmision,
 @IdComprobanteOriginal
)

SELECT @IdSubdiario=@@identity

RETURN(@IdSubdiario)