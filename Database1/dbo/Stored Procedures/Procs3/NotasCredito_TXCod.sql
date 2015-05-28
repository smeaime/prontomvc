






























CREATE Procedure [dbo].[NotasCredito_TXCod]
@NroCre int
As
SELECT *
FROM NotasCredito
WHERE (NumeroNotaCredito = @NroCre)































