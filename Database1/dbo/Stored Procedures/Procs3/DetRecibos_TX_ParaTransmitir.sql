


CREATE Procedure [dbo].[DetRecibos_TX_ParaTransmitir]
AS 
SELECT *
FROM DetalleRecibos
WHERE IsNull(EnviarEmail,1)=1


