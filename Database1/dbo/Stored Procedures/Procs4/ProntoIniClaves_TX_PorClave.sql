
CREATE Procedure [dbo].[ProntoIniClaves_TX_PorClave]

@Clave varchar(1000),
@IdProntoIniClave int = Null

AS 

SET @IdProntoIniClave=IsNull(@IdProntoIniClave,-1)

SELECT *
FROM ProntoIniClaves
WHERE Clave=@Clave and IdProntoIniClave<>@IdProntoIniClave
