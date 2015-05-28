


CREATE Procedure [dbo].[DetRecibos_TX_SetearComoTransmitido]
AS 
UPDATE DetalleRecibos 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


