


CREATE Procedure [dbo].[BancoChequeras_TT]
AS 
SELECT 
 BancoChequeras.IdBancoChequera,
 Bancos.Nombre as [Banco],
 CuentasBancarias.Cuenta,
 BancoChequeras.NumeroChequera as [Nro. chequera],
 BancoChequeras.DesdeCheque as [Desde],
 BancoChequeras.HastaCheque as [Hasta],
 BancoChequeras.Fecha,
 BancoChequeras.ProximoNumeroCheque as [Prox.cheque],
 BancoChequeras.ChequeraPagoDiferido as [p/pagos diferidos]
FROM BancoChequeras
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=BancoChequeras.IdBanco
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=BancoChequeras.IdCuentaBancaria
WHERE IsNull(BancoChequeras.Activa,'SI')='SI'
ORDER by Bancos.Nombre,BancoChequeras.Fecha


