




CREATE PROCEDURE [dbo].[Valores_TX_TodosSF_HastaFecha_DebitosYCreditos]
@FechaHasta datetime
AS
SELECT *
FROM Valores 
WHERE FechaComprobante<=@FechaHasta and (IdTipoComprobante=28 or IdTipoComprobante=29)
ORDER BY FechaComprobante





