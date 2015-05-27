





CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM ComprobantesProveedores 
WHERE FechaRecepcion<=@FechaHasta
ORDER BY FechaRecepcion





