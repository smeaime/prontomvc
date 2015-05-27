




CREATE Procedure [dbo].[BancoChequeras_TL]
AS 
SELECT 
 IdBancoChequera,
 'Cuenta : ' + CuentasBancarias.Cuenta + ' Nro. : ' + 
	Case When NumeroChequera is null 
		Then '' 
		Else Convert(varchar,NumeroChequera) End 
 as [Titulo]
FROM BancoChequeras 
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=BancoChequeras.IdCuentaBancaria
ORDER by Cuenta,NumeroChequera




