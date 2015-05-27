


CREATE Procedure [dbo].[DetRecibosRubrosContables_TX_SetearComoTransmitido]
AS 
UPDATE DetalleRecibosRubrosContables 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


