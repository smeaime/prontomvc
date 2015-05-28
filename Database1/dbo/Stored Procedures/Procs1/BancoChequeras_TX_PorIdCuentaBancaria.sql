
CREATE Procedure [dbo].[BancoChequeras_TX_PorIdCuentaBancaria]

@IdCuentaBancaria int

AS 

SELECT 
 IdBancoChequera,
 'Cuenta : ' + CuentasBancarias.Cuenta + ' Nro. : ' + Case When NumeroChequera is null Then '' Else Convert(varchar,NumeroChequera) End as [Titulo]
FROM BancoChequeras 
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=BancoChequeras.IdCuentaBancaria
WHERE BancoChequeras.IdCuentaBancaria=@IdCuentaBancaria
ORDER by Cuenta,NumeroChequera
