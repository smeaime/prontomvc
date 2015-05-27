




CREATE Procedure [dbo].[Sectores_TX_SetearComoTransmitido]
AS 
Update Sectores
SET EnviarEmail=0
WHERE EnviarEmail<>0




