





























CREATE Procedure [dbo].[DetNotasCredito_T]
@IdDetalleNotaCredito int
AS 
SELECT *
FROM DetalleNotasCredito
where (IdDetalleNotaCredito=@IdDetalleNotaCredito)






























