


CREATE Procedure [dbo].[DetRecibosCuentas_TX_ParaTransmitir]
AS 
SELECT *
FROM DetalleRecibosCuentas 
WHERE IsNull(EnviarEmail,1)=1


