


CREATE Procedure [dbo].[DetRecibosCuentas_TX_SetearComoTransmitido]
AS 
UPDATE DetalleRecibosCuentas 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


