




CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleNotaDebito]
@IdDetalleNotaDebito int
AS 
DELETE FROM Valores
WHERE (IdDetalleNotaDebito=@IdDetalleNotaDebito)





