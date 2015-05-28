
CREATE PROCEDURE [dbo].[NotasCredito_TX_EntreFechasParaGeneracionContable]

@Desde datetime,
@Hasta datetime

AS

SELECT 
	NotasCredito.IdNotaCredito, 
	NotasCredito.TipoABC AS [A/B/E],
	NotasCredito.NumeroNotaCredito AS [Nota credito],
	NotasCredito.FechaNotaCredito AS [Fecha credito]
FROM NotasCredito 
WHERE (NotasCredito.FechaNotaCredito between @Desde and @hasta) and 
	 (NotasCredito.Anulada is null or NotasCredito.Anulada<>'SI')
ORDER BY NotasCredito.FechaNotaCredito
