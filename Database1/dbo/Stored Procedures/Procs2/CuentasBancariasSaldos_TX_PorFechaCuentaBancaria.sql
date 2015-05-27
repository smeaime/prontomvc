CREATE Procedure [dbo].[CuentasBancariasSaldos_TX_PorFechaCuentaBancaria]

@Fecha datetime,
@IdCuentaBancaria int

AS 

SELECT *
FROM CuentasBancariasSaldos
WHERE IdCuentaBancaria=@IdCuentaBancaria and Fecha=@Fecha