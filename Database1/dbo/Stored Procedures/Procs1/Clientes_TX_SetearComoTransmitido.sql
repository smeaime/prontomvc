


CREATE Procedure [dbo].[Clientes_TX_SetearComoTransmitido]
AS 
UPDATE Clientes
SET EnviarEmail=0
WHERE EnviarEmail<>0


