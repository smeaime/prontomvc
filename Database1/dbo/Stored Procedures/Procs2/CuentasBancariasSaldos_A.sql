CREATE Procedure [dbo].[CuentasBancariasSaldos_A]

@IdCuentaBancariaSaldo int  output,
@IdCuentaBancaria int,
@Fecha datetime,
@SaldoInicial numeric(18,2),
@SaldoAnteriorPrimerDiaMes numeric(18,2)

AS 

INSERT INTO [CuentasBancariasSaldos]
(
 IdCuentaBancaria,
 Fecha,
 SaldoInicial,
 SaldoAnteriorPrimerDiaMes
)
VALUES
(
 @IdCuentaBancaria,
 @Fecha,
 @SaldoInicial,
 @SaldoAnteriorPrimerDiaMes
)

SELECT @IdCuentaBancariaSaldo=@@identity

RETURN(@IdCuentaBancariaSaldo)