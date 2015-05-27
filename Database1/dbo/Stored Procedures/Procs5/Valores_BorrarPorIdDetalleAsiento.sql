
























CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleAsiento]
@IdDetalleAsiento int
AS 
DELETE FROM Valores
WHERE (IdDetalleAsiento=@IdDetalleAsiento)

























