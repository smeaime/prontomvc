CREATE  Procedure [dbo].[CuentasBancariasSaldos_M]

@IdCuentaBancariaSaldo int ,
@IdCuentaBancaria int,
@Fecha datetime,
@SaldoInicial numeric(18,2),
@SaldoAnteriorPrimerDiaMes numeric(18,2)

AS

UPDATE CuentasBancariasSaldos
SET
 IdCuentaBancaria=@IdCuentaBancaria,
 Fecha=@Fecha,
 SaldoInicial=@SaldoInicial,
 SaldoAnteriorPrimerDiaMes=@SaldoAnteriorPrimerDiaMes
WHERE (IdCuentaBancariaSaldo=@IdCuentaBancariaSaldo)

RETURN(@IdCuentaBancariaSaldo)