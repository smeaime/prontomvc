














CREATE Procedure [dbo].[Valores_BorrarPorIdPlazoFijoFin]
@IdPlazoFijo int
AS 
DELETE FROM Valores
WHERE IdPlazoFijoFin=@IdPlazoFijo














