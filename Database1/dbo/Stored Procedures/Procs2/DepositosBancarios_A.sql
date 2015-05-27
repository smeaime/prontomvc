CREATE Procedure [dbo].[DepositosBancarios_A]

@IdDepositoBancario int  output,
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

Insert into [DepositosBancarios]
(
 FechaDeposito,
 IdBanco,
 NumeroDeposito,
 Observaciones,
 Efectivo,
 IdCuentaBancaria,
 Anulado,
 IdAutorizaAnulacion,
 FechaAnulacion,
 IdCaja,
 IdMonedaEfectivo,
 CotizacionMoneda
)
Values
(
 @FechaDeposito,
 @IdBanco,
 @NumeroDeposito,
 @Observaciones,
 @Efectivo,
 @IdCuentaBancaria,
 @Anulado,
 @IdAutorizaAnulacion,
 @FechaAnulacion,
 @IdCaja,
 @IdMonedaEfectivo,
 @CotizacionMoneda
)

Select @IdDepositoBancario=@@identity

Return(@IdDepositoBancario)