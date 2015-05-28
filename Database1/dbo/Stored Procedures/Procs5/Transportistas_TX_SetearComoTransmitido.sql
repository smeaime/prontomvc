




CREATE Procedure [dbo].[Transportistas_TX_SetearComoTransmitido]
AS 
Update Transportistas
SET EnviarEmail=0
WHERE EnviarEmail<>0




