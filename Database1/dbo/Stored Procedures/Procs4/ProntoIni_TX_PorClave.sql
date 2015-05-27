CREATE Procedure [dbo].[ProntoIni_TX_PorClave]

@Clave varchar(1000),
@IdUsuario int

AS 

SELECT TOP 1 P.Valor
FROM ProntoIni P 
LEFT OUTER JOIN ProntoIniClaves ON ProntoIniClaves.IdProntoIniClave=P.IdProntoIniClave
WHERE ProntoIniClaves.Clave=@Clave and (@IdUsuario=-1 or P.IdUsuario=@IdUsuario)