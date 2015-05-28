




CREATE Procedure [dbo].[Cuentas_TX_SetearComoTransmitido]
AS 
Update Cuentas
SET EnviarEmail=0
WHERE EnviarEmail<>0




