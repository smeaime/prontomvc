
CREATE Procedure [dbo].[DetOrdenesPagoCuentas_M]

@IdDetalleOrdenPagoCuentas int,
@IdOrdenPago int,
@IdCuenta int,
@CodigoCuenta varchar(10),
@Debe numeric(12,2),
@Haber numeric(12,2),
@IdObra int,
@IdCuentaGasto int,
@IdCuentaBancaria int,
@IdCaja int,
@IdMoneda int,
@CotizacionMonedaDestino numeric(18,4),
@IdTarjetaCredito int

AS

UPDATE DetalleOrdenesPagoCuentas
SET 
 IdOrdenPago=@IdOrdenPago,
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
 IdTarjetaCredito=@IdTarjetaCredito
WHERE (IdDetalleOrdenPagoCuentas=@IdDetalleOrdenPagoCuentas)

RETURN(@IdDetalleOrdenPagoCuentas)
