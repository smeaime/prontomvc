




CREATE PROCEDURE [dbo].[Subdiarios_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM Subdiarios
WHERE Subdiarios.FechaComprobante<=@FechaHasta
ORDER BY FechaComprobante




