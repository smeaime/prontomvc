


CREATE Procedure [dbo].[Subdiarios_TX_SetearComoTransmitido]
AS 
UPDATE Subdiarios 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


