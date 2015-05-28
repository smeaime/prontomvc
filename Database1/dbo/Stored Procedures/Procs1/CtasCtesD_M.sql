


CREATE  Procedure [dbo].[CtasCtesD_M]
@IdCtaCte int,
@IdCliente int,
@Fecha datetime,
@FechaVencimiento datetime,
@IdTipoComp int,
@IdComprobante int,
@NumeroComprobante int,
@IdImputacion int,
@ImporteTotal money,
@Saldo money,
@ImporteParteEnDolares numeric(18,2),
@SaldoImporteParteEnDolares numeric(18,2),
@ImporteParteEnPesos numeric(18,2),
@SaldoImporteParteEnPesos numeric(18,2),
@Cotizacion numeric(18,3),
@IdDetalleRecibo int,
@ImporteTotalDolar numeric(18,2),
@SaldoDolar numeric(18,2),
@IdMoneda int,
@CotizacionMoneda numeric(18,4),
@IdDetalleNotaCreditoImputaciones int,
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdCtaCteOriginal int,
@FechaImportacionTransmision datetime,
@IdComprobanteOriginal int,
@IdImputacionOriginal int,
@CuitClienteTransmision varchar(13)
As 
Update CuentasCorrientesDeudores
Set  
 IdCliente=@IdCliente,
 Fecha=@Fecha,
 FechaVencimiento=@FechaVencimiento,
 IdTipoComp=@IdTipoComp,
 IdComprobante=@IdComprobante,
 NumeroComprobante=@NumeroComprobante,
 IdImputacion=@IdImputacion,
 ImporteTotal=@ImporteTotal,
 Saldo=@Saldo,
 ImporteParteEnDolares=@ImporteParteEnDolares,
 SaldoImporteParteEnDolares=@SaldoImporteParteEnDolares,
 ImporteParteEnPesos=@ImporteParteEnPesos,
 SaldoImporteParteEnPesos=@SaldoImporteParteEnPesos,
 Cotizacion=@Cotizacion,
 IdDetalleRecibo=@IdDetalleRecibo,
 ImporteTotalDolar=@ImporteTotalDolar,
 SaldoDolar=@SaldoDolar,
 IdMoneda=@IdMoneda,
 CotizacionMoneda=@CotizacionMoneda,
 IdDetalleNotaCreditoImputaciones=@IdDetalleNotaCreditoImputaciones,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdCtaCteOriginal=@IdCtaCteOriginal,
 FechaImportacionTransmision=@FechaImportacionTransmision,
 IdComprobanteOriginal=@IdComprobanteOriginal,
 IdImputacionOriginal=@IdImputacionOriginal,
 CuitClienteTransmision=@CuitClienteTransmision
Where (IdCtaCte=@IdCtaCte)
Return(@IdCtaCte)


