


CREATE Procedure [dbo].[DetFacturas_TX_ParaTransmitir]
AS 
SELECT *
FROM DetalleFacturas
WHERE IsNull(EnviarEmail,1)=1


