










CREATE Procedure [dbo].[GruposActivosFijos_TL]
AS 
SELECT 
 IdGrupoActivoFijo,
 Descripcion as [Titulo]
FROM GruposActivosFijos
ORDER by Descripcion











