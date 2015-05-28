




CREATE  Procedure [dbo].[GruposObras_M]
@IdGrupoObra int,
@Descripcion varchar(50)
As
Update GruposObras
Set
 Descripcion=@Descripcion
Where (IdGrupoObra=@IdGrupoObra)
Return(@IdGrupoObra)





