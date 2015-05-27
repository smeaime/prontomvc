CREATE Procedure [dbo].[CuentasBancariasSaldos_TX_PorFechaBanco]

@Fecha datetime,
@IdBanco int

AS 

SELECT Sum(IsNull(CuentasBancariasSaldos.SaldoInicial,0)) as [SaldoInicial], Sum(IsNull(CuentasBancariasSaldos.SaldoAnteriorPrimerDiaMes,0)) as [SaldoAnteriorPrimerDiaMes]
FROM CuentasBancariasSaldos
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=CuentasBancariasSaldos.IdCuentaBancaria
WHERE (@IdBanco=-1 or CuentasBancarias.IdBanco=@IdBanco) and CuentasBancariasSaldos.Fecha=@Fecha