


CREATE Procedure [dbo].[Facturas_TX_SetearComoTransmitido]
AS 
UPDATE Facturas 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


