




CREATE PROCEDURE [dbo].[Recibos_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM Recibos 
WHERE FechaRecibo<=@FechaHasta
ORDER BY FechaRecibo





