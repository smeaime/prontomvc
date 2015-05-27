


CREATE Procedure [dbo].[CtasCtesD_TX_SetearComoTransmitido]
AS 
UPDATE CuentasCorrientesDeudores 
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)=1


