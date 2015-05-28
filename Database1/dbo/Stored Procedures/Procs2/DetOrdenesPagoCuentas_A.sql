
CREATE Procedure [dbo].[DetOrdenesPagoCuentas_A]

@IdDetalleOrdenPagoCuentas int  output,
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

INSERT INTO [DetalleOrdenesPagoCuentas]
(
 IdOrdenPago,
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
 IdTarjetaCredito
)
VALUES 
(
 @IdOrdenPago,
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
 @IdTarjetaCredito
)

SELECT @IdDetalleOrdenPagoCuentas=@@identity
RETURN(@IdDetalleOrdenPagoCuentas)
