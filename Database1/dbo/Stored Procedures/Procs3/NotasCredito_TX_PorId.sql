




CREATE Procedure [dbo].[NotasCredito_TX_PorId]
@IdNotaCredito int
AS 
SELECT *
FROM NotasCredito
WHERE (IdNotaCredito=@IdNotaCredito)





