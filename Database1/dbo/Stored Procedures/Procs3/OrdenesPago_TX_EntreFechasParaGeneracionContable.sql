




CREATE PROCEDURE [dbo].[OrdenesPago_TX_EntreFechasParaGeneracionContable]
@Desde datetime,
@Hasta datetime
AS
SELECT 
 op.IdOrdenPago, 
 op.NumeroOrdenPago as [Numero], 
 op.FechaOrdenPago as [Fecha Pago]
FROM OrdenesPago op
WHERE (op.FechaOrdenPago between @Desde and @hasta) and 
	 (op.Anulada is null or op.Anulada<>'SI')
ORDER BY op.FechaOrdenPago,op.NumeroOrdenPago




