




CREATE PROCEDURE [dbo].[Devoluciones_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM Devoluciones 
WHERE FechaDevolucion<=@FechaHasta
ORDER BY FechaDevolucion





