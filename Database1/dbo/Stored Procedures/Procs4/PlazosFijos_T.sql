





















CREATE Procedure [dbo].[PlazosFijos_T]
@IdPlazoFijo int
AS 
SELECT *
FROM PlazosFijos
WHERE (IdPlazoFijo=@IdPlazoFijo)






















