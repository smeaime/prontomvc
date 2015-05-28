


CREATE Procedure [dbo].[DetFacturas_TX_SetearComoTransmitido]
AS 
UPDATE DetalleFacturas 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


