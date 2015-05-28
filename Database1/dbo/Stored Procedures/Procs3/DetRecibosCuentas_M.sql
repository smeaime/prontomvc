


CREATE Procedure [dbo].[DetRecibosCuentas_M]
@IdDetalleReciboCuentas int,
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
UPDATE DetalleRecibosCuentas
SET 
 IdRecibo=@IdRecibo,
 IdCuenta=@IdCuenta,
 CodigoCuenta=@CodigoCuenta,
 Debe=@Debe,
 Haber=@Haber,
 IdObra=@IdObra,
 IdCuentaGasto=@IdCuentaGasto,
 IdCuentaBancaria=@IdCuentaBancaria,
 IdCaja=@IdCaja,
 IdMoneda=@IdMoneda,
 CotizacionMonedaDestino=@CotizacionMonedaDestino,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdReciboOriginal=@IdReciboOriginal,
 IdDetalleReciboCuentasOriginal=@IdDetalleReciboCuentasOriginal,
 FechaImportacionTransmision=@FechaImportacionTransmision
WHERE (IdDetalleReciboCuentas=@IdDetalleReciboCuentas)
RETURN(@IdDetalleReciboCuentas)


