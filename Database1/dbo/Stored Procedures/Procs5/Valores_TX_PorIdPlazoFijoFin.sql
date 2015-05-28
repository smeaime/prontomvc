














CREATE Procedure [dbo].[Valores_TX_PorIdPlazoFijoFin]
@IdPlazoFijo int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdPlazoFijoFin=@IdPlazoFijo














