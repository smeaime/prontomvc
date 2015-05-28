


















CREATE PROCEDURE [dbo].[NotasDebito_TX_EntreFechasParaGeneracionContable]
@Desde datetime,
@Hasta datetime
AS
SELECT 
	NotasDebito.IdNotaDebito, 
	NotasDebito.TipoABC AS [A/B/E],
	NotasDebito.NumeroNotaDebito AS [Nota debito], 
	NotasDebito.FechaNotaDebito AS [Fecha debito]
FROM NotasDebito 
WHERE (NotasDebito.FechaNotaDebito between @Desde and @hasta) and 
	 (NotasDebito.Anulada is null or NotasDebito.Anulada<>'SI')
ORDER BY NotasDebito.FechaNotaDebito



















