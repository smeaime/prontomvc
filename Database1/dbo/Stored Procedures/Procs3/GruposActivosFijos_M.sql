










CREATE  Procedure [dbo].[GruposActivosFijos_M]
@IdGrupoActivoFijo int,
@Descripcion varchar(50),
@Clase varchar(1)
As
Update GruposActivosFijos
Set
 Descripcion=@Descripcion,
 Clase=@Clase
Where (IdGrupoActivoFijo=@IdGrupoActivoFijo)
Return(@IdGrupoActivoFijo)











