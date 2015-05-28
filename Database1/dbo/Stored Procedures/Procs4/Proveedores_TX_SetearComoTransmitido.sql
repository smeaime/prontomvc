




CREATE Procedure [dbo].[Proveedores_TX_SetearComoTransmitido]
AS 
Update Proveedores
SET EnviarEmail=0
WHERE EnviarEmail<>0




