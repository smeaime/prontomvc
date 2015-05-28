














CREATE Procedure [dbo].[Valores_BorrarPorIdPlazoFijo]
@IdPlazoFijo int
AS 
DELETE FROM Valores
WHERE IdPlazoFijoInicio=@IdPlazoFijo or IdPlazoFijoFin=@IdPlazoFijo














