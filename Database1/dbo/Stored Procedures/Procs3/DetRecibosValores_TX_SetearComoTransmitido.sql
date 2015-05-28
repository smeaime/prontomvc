


CREATE Procedure [dbo].[DetRecibosValores_TX_SetearComoTransmitido]
AS 
UPDATE DetalleRecibosValores 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


