


CREATE Procedure [dbo].[DetRecibosCuentas_A]
@IdDetalleReciboCuentas int  output,
@IdRecibo int,
@IdCuenta int,
@CodigoCuenta varchar(10),
@Debe numeric(19,2),
@Haber numeric(19,2),
@IdObra int,
@IdCuentaGasto int,
@IdCuentaBancaria int,
@IdCaja int,
@IdMoneda int,
@CotizacionMonedaDestino numeric(18,3),
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdReciboOriginal int,
@IdDetalleReciboCuentasOriginal int,
@FechaImportacionTransmision datetime

AS 
INSERT INTO [DetalleRecibosCuentas]
(
 IdRecibo,
 IdCuenta,
 CodigoCuenta,
 Debe,
 Haber,
 IdObra,
 IdCuentaGasto,
 IdCuentaBancaria,
 IdCaja,
 IdMoneda,
 CotizacionMonedaDestino,
 EnviarEmail,
 IdOrigenTransmision,
 IdReciboOriginal,
 IdDetalleReciboCuentasOriginal,
 FechaImportacionTransmision
)
Values
(
 @IdRecibo,
 @IdCuenta,
 @CodigoCuenta,
 @Debe,
 @Haber,
 @IdObra,
 @IdCuentaGasto,
 @IdCuentaBancaria,
 @IdCaja,
 @IdMoneda,
 @CotizacionMonedaDestino,
 @EnviarEmail,
 @IdOrigenTransmision,
 @IdReciboOriginal,
 @IdDetalleReciboCuentasOriginal,
 @FechaImportacionTransmision
)
SELECT @IdDetalleReciboCuentas=@@identity
RETURN(@IdDetalleReciboCuentas)


