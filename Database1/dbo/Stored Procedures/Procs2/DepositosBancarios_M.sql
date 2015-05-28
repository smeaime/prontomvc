
















CREATE Procedure [dbo].[DepositosBancarios_M]
@IdDepositoBancario int,
@FechaDeposito datetime,
@IdBanco int,
@NumeroDeposito int,
@Observaciones ntext,
@Efectivo numeric(18,2),
@IdCuentaBancaria int,
@Anulado varchar(2),
@IdAutorizaAnulacion int,
@FechaAnulacion datetime,
@IdCaja int,
@IdMonedaEfectivo int,
@CotizacionMoneda numeric(18,4)
As
Update DepositosBancarios
Set  
 FechaDeposito=@FechaDeposito,
 IdBanco=@IdBanco,
 NumeroDeposito=@NumeroDeposito,
 Observaciones=@Observaciones,
 Efectivo=@Efectivo,
 IdCuentaBancaria=@IdCuentaBancaria,
 Anulado=@Anulado,
 IdAutorizaAnulacion=@IdAutorizaAnulacion,
 FechaAnulacion=@FechaAnulacion,
 IdCaja=@IdCaja,
 IdMonedaEfectivo=@IdMonedaEfectivo,
 CotizacionMoneda=@CotizacionMoneda
Where (IdDepositoBancario=@IdDepositoBancario)
Return(@IdDepositoBancario)
















