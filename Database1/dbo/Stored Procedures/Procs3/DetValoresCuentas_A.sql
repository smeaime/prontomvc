
CREATE Procedure [dbo].[DetValoresCuentas_A]
@IdDetalleValorCuentas int  output,
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
INSERT INTO [DetalleValoresCuentas]
(
 IdValor,
 IdCuenta,
 CodigoCuenta,
 Debe,
 Haber,
 IdObra,
 IdCuentaGasto,
 IdCuentaBancaria,
 IdCaja,
 IdMoneda,
 CotizacionMonedaDestino
)
VALUES 
(
 @IdValor,
 @IdCuenta,
 @CodigoCuenta,
 @Debe,
 @Haber,
 @IdObra,
 @IdCuentaGasto,
 @IdCuentaBancaria,
 @IdCaja,
 @IdMoneda,
 @CotizacionMonedaDestino
)
SELECT @IdDetalleValorCuentas=@@identity
RETURN(@IdDetalleValorCuentas)
