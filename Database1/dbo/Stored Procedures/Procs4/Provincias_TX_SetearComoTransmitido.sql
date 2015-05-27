




CREATE Procedure [dbo].[Provincias_TX_SetearComoTransmitido]
AS 
Update Provincias
SET EnviarEmail=0
WHERE EnviarEmail<>0




