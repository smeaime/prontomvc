













CREATE  Procedure [dbo].[DepositosBancarios_TX_EntreFechas]
@Desde datetime,
@Hasta datetime
AS
SELECT *
FROM DepositosBancarios 
WHERE (DepositosBancarios.FechaDeposito between @Desde and @hasta) and
	 (DepositosBancarios.Anulado is null or DepositosBancarios.Anulado<>'SI')
ORDER BY DepositosBancarios.FechaDeposito













