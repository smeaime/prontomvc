














CREATE Procedure [dbo].[Valores_TX_PorIdPlazoFijoInicio]
@IdPlazoFijo int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdPlazoFijoInicio=@IdPlazoFijo














