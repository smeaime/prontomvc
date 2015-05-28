




CREATE PROCEDURE [dbo].[PlazosFijos_TX_TodosSF_HastaFecha_Inicio]
@FechaHasta datetime
AS
SELECT *
FROM PlazosFijos 
WHERE FechaInicioPlazoFijo<=@FechaHasta
ORDER BY FechaInicioPlazoFijo





