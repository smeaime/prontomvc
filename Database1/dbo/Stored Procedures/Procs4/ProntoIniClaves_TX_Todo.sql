
CREATE Procedure [dbo].[ProntoIniClaves_TX_Todo]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='0C0300'

SELECT 
 ProntoIniClaves.IdProntoIniClave,
 ProntoIniClaves.Clave as [Clave],
 ProntoIniClaves.ValorPorDefecto as [Valor por defecto],
 ProntoIniClaves.Descripcion as [Descripcion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProntoIniClaves
ORDER BY ProntoIniClaves.Clave
