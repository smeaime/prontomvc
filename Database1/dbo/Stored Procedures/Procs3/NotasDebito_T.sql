






























CREATE Procedure [dbo].[NotasDebito_T]
@IdNotaDebito int
AS 
SELECT *
FROM NotasDebito
where (IdNotaDebito=@IdNotaDebito)































