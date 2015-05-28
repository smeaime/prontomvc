


CREATE Procedure [dbo].[Recibos_TX_SetearComoTransmitido]
AS 
UPDATE Recibos 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


