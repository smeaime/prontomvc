




CREATE Procedure [dbo].[UnidadesOperativas_TX_SetearComoTransmitido]
AS 
Update UnidadesOperativas
SET EnviarEmail=0
WHERE EnviarEmail<>0




