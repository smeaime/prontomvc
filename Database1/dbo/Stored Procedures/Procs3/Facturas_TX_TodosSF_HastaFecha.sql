




CREATE PROCEDURE [dbo].[Facturas_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM Facturas 
WHERE FechaFactura<=@FechaHasta
ORDER BY FechaFactura





