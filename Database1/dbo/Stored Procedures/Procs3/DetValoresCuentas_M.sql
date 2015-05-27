
CREATE Procedure [dbo].[DetValoresCuentas_M]
@IdDetalleValorCuentas int,
@IdValor int,
@IdCuenta int,
@CodigoCuenta varchar(10),
@Debe numeric(12,2),
@Haber numeric(12,2),
@IdObra int,
@IdCuentaGasto int,
@IdCuentaBancaria int,
@IdCaja int,
@IdMoneda int,
@CotizacionMonedaDestino numeric(18,4)
AS
UPDATE DetalleValoresCuentas
SET 
 IdValor=@IdValor,
 IdCuenta=@IdCuenta,
 CodigoCuenta=@CodigoCuenta,
 Debe=@Debe,
 Haber=@Haber,
 IdObra=@IdObra,
 IdCuentaGasto=@IdCuentaGasto,
 IdCuentaBancaria=@IdCuentaBancaria,
 IdCaja=@IdCaja,
 IdMoneda=@IdMoneda,
 CotizacionMonedaDestino=@CotizacionMonedaDestino
WHERE (IdDetalleValorCuentas=@IdDetalleValorCuentas)
RETURN(@IdDetalleValorCuentas)
