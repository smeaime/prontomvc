










CREATE Procedure [dbo].[GruposActivosFijos_T]
@IdGrupoActivoFijo int
AS 
SELECT *
FROM GruposActivosFijos
WHERE (IdGrupoActivoFijo=@IdGrupoActivoFijo)











