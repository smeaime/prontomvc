






CREATE Procedure [dbo].[Articulos_BorrarPorIdRubro]
@IdRubro int
AS
DELETE FROM Articulos
WHERE IdRubro=@IdRubro







