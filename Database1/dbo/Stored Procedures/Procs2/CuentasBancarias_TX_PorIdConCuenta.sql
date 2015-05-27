CREATE Procedure [dbo].[CuentasBancarias_TX_PorIdConCuenta]

@IdCuentaBancaria int

AS 

SELECT 
 CuentasBancarias.*,
 Bancos.IdCuenta,
 Bancos.Nombre as [Banco]
FROM CuentasBancarias
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
WHERE (IdCuentaBancaria=@IdCuentaBancaria)