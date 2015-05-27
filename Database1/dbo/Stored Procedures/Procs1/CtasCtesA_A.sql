
CREATE Procedure [dbo].[CtasCtesA_A]

@IdCtaCte int  output,
@IdProveedor int,
@Fecha datetime,
@IdTipoComp int,
@IdComprobante int,
@NumeroComprobante int,
@IdImputacion int,
@ImporteTotal numeric(18,2),
@Saldo numeric(18,2),
@FechaVencimiento datetime,
@IdDetalleOrdenPago int,
@CotizacionDolar numeric(18,4),
@ImporteTotalDolar numeric(18,2),
@SaldoDolar numeric(18,2),
@IdMoneda int,
@CotizacionMoneda numeric(18,4),
@CotizacionEuro numeric(18,4),
@ImporteTotalEuro numeric(18,2),
@SaldoEuro numeric(18,2)

AS 

INSERT INTO CuentasCorrientesAcreedores
(
 IdProveedor,
 Fecha,
 IdTipoComp,
 IdComprobante,
 NumeroComprobante,
 IdImputacion,
 ImporteTotal,
 Saldo,
 FechaVencimiento,
 IdDetalleOrdenPago,
 CotizacionDolar,
 ImporteTotalDolar,
 SaldoDolar,
 IdMoneda,
 CotizacionMoneda,
 CotizacionEuro,
 ImporteTotalEuro,
 SaldoEuro
)
VALUES
(
 @IdProveedor,
 @Fecha,
 @IdTipoComp,
 @IdComprobante,
 @NumeroComprobante,
 @IdImputacion,
 @ImporteTotal,
 @Saldo,
 @FechaVencimiento,
 @IdDetalleOrdenPago,
 @CotizacionDolar,
 @ImporteTotalDolar,
 @SaldoDolar,
 @IdMoneda,
 @CotizacionMoneda,
 @CotizacionEuro,
 @ImporteTotalEuro,
 @SaldoEuro
)
SELECT @IdCtaCte=@@identity

RETURN(@IdCtaCte)
