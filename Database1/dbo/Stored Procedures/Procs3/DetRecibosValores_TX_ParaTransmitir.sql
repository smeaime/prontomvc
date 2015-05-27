


CREATE Procedure [dbo].[DetRecibosValores_TX_ParaTransmitir]
AS 
SELECT *
FROM DetalleRecibosValores 
WHERE IsNull(EnviarEmail,1)=1


