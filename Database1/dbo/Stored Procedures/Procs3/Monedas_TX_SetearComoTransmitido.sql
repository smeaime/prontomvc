




CREATE Procedure [dbo].[Monedas_TX_SetearComoTransmitido]
AS 
Update Monedas
SET EnviarEmail=0
WHERE EnviarEmail<>0




