


















CREATE PROCEDURE [dbo].[Devoluciones_TX_EntreFechasParaGeneracionContable]
@Desde datetime,
@Hasta datetime
AS
SELECT 
	Devoluciones.IdDevolucion, 
	Devoluciones.TipoABC AS [A/B/E],
	Devoluciones.NumeroDevolucion AS [Devolucion], 
	Devoluciones.FechaDevolucion AS [Fecha dev.]
FROM Devoluciones 
WHERE (Devoluciones.FechaDevolucion between @Desde and @hasta) and 
	 (Devoluciones.Anulada is null or Devoluciones.Anulada<>'SI')
ORDER BY Devoluciones.FechaDevolucion



















