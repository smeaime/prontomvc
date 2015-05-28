CREATE Procedure [dbo].[NotasDebito_TX_PorId]

@IdNotaDebito int

AS 

SELECT *
FROM NotasDebito
WHERE (IdNotaDebito=@IdNotaDebito)