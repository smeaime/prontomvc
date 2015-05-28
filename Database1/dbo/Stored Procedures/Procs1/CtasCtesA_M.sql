




CREATE  Procedure [dbo].[CtasCtesA_M]
@IdCtaCte int,
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
As
Update CuentasCorrientesAcreedores
Set 
 IdProveedor=@IdProveedor,
 Fecha=@Fecha,
 IdTipoComp=@IdTipoComp,
 IdComprobante=@IdComprobante,
 NumeroComprobante=@NumeroComprobante,
 IdImputacion=@IdImputacion,
 ImporteTotal=@ImporteTotal,
 Saldo=@Saldo,
 FechaVencimiento=@FechaVencimiento,
 IdDetalleOrdenPago=@IdDetalleOrdenPago,
 CotizacionDolar=@CotizacionDolar,
 ImporteTotalDolar=@ImporteTotalDolar,
 SaldoDolar=@SaldoDolar,
 IdMoneda=@IdMoneda,
 CotizacionMoneda=@CotizacionMoneda,
 CotizacionEuro=@CotizacionEuro,
 ImporteTotalEuro=@ImporteTotalEuro,
 SaldoEuro=@SaldoEuro
Where (IdCtaCte=@IdCtaCte)
Return(@IdCtaCte)




