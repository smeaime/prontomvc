
CREATE Procedure [dbo].[CuentasBancarias_TX_PorId]

@IdCuentaBancaria int

AS 

SELECT *
FROM CuentasBancarias
WHERE (IdCuentaBancaria=@IdCuentaBancaria)
