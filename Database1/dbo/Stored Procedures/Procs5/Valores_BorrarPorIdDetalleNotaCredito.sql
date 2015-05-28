




CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleNotaCredito]
@IdDetalleNotaCredito int
AS 
DELETE FROM Valores
WHERE (IdDetalleNotaCredito=@IdDetalleNotaCredito)





