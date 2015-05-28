CREATE Procedure [dbo].[CuentasBancariasSaldos_E]

@IdCuentaBancariaSaldo int 

AS 

DELETE CuentasBancariasSaldos
WHERE (IdCuentaBancariaSaldo=@IdCuentaBancariaSaldo)