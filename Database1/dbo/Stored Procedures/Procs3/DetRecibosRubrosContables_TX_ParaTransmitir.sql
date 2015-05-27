


CREATE Procedure [dbo].[DetRecibosRubrosContables_TX_ParaTransmitir]
AS 
SELECT *
FROM DetalleRecibosRubrosContables 
WHERE IsNull(EnviarEmail,1)=1


