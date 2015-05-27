
CREATE Procedure [dbo].[CalidadesClad_TL]

AS 

SELECT IdCalidadClad, Descripcion as Titulo
FROM CalidadesClad
ORDER BY Descripcion
