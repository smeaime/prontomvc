CREATE Procedure [dbo].[Bancos_TX_PorIdCuentaBancaria]

@IdCuentaBancaria int

AS 

SELECT 
 CuentasBancarias.IdCuentaBancaria,
 CuentasBancarias.IdBanco,
 Bancos.Nombre as [Banco],
 Bancos.CodigoResumen as [CodigoResumen],
 CuentasBancarias.Cuenta as [Cuenta]
FROM CuentasBancarias 
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
WHERE CuentasBancarias.IdCuentaBancaria=@IdCuentaBancaria