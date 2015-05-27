
CREATE Procedure [dbo].[CalidadesClad_T]

@IdCalidadClad int

AS 

SELECT *
FROM CalidadesClad
WHERE (IdCalidadClad=@IdCalidadClad)
