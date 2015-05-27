CREATE Procedure [dbo].[CuentasBancariasSaldos_TX_TT]

@IdCuentaBancariaSaldo int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0524500'

SELECT 
 CuentasBancariasSaldos.IdCuentaBancariaSaldo as [IdCuentaBancariaSaldo],
 CuentasBancarias.Detalle as [Cuenta],
 Bancos.Nombre as [Banco],
 CuentasBancariasSaldos.Fecha as [Fecha],
 CuentasBancariasSaldos.SaldoInicial as [Saldo inicial],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasBancariasSaldos
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=CuentasBancariasSaldos.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
WHERE (CuentasBancariasSaldos.IdCuentaBancariaSaldo=@IdCuentaBancariaSaldo)