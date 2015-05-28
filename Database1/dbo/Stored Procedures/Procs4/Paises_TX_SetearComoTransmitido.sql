




CREATE Procedure [dbo].[Paises_TX_SetearComoTransmitido]
AS 
Update Paises
SET EnviarEmail=0
WHERE EnviarEmail<>0




