


















CREATE PROCEDURE [dbo].[Recibos_TX_EntreFechasParaGeneracionContable]
@Desde datetime,
@Hasta datetime
AS
SELECT 
	Recibos.IdRecibo, 
	Recibos.NumeroRecibo AS [Recibo], 
	Recibos.FechaRecibo AS [Fecha recibo]
FROM Recibos 
WHERE (Recibos.FechaRecibo between @Desde and @hasta) and 
	 (Recibos.Anulado is null or Recibos.Anulado<>'SI')
ORDER BY Recibos.FechaRecibo



















