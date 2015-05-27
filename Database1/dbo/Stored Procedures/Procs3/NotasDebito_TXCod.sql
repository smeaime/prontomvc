






























CREATE Procedure [dbo].[NotasDebito_TXCod]
@NroFac int
As
SELECT *
FROM NotasDebito
WHERE (NumeroNotaDebito = @NroFac)































