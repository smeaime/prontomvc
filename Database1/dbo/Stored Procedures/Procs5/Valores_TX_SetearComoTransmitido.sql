


CREATE Procedure [dbo].[Valores_TX_SetearComoTransmitido]
AS 
UPDATE Valores 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


