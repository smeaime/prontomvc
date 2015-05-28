




CREATE Procedure [dbo].[PlazosFijos_TX_PorId]
@IdPlazoFijo int
AS 
SELECT *
FROM PlazosFijos
WHERE (IdPlazoFijo=@IdPlazoFijo)





