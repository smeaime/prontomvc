CREATE Procedure [dbo].[CuentasBancariasSaldos_T]

@IdCuentaBancariaSaldo int

AS 

SELECT *
FROM CuentasBancariasSaldos
WHERE (IdCuentaBancariaSaldo=@IdCuentaBancariaSaldo)