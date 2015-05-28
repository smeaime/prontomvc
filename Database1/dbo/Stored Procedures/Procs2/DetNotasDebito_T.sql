





























CREATE Procedure [dbo].[DetNotasDebito_T]
@IdDetalleNotaDebito int
AS 
SELECT *
FROM DetalleNotasDebito
where (IdDetalleNotaDebito=@IdDetalleNotaDebito)






























