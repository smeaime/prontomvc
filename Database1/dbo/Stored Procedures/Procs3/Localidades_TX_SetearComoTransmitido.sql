




CREATE Procedure [dbo].[Localidades_TX_SetearComoTransmitido]
AS 
Update Localidades
SET EnviarEmail=0
WHERE EnviarEmail<>0




