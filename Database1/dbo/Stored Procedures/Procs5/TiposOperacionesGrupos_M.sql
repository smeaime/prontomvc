


CREATE  Procedure [dbo].[TiposOperacionesGrupos_M]

@IdTipoOperacionGrupo int ,
@Descripcion varchar(50)

AS

UPDATE TiposOperacionesGrupos
SET
 Descripcion=@Descripcion
WHERE (IdTipoOperacionGrupo=@IdTipoOperacionGrupo)

RETURN(@IdTipoOperacionGrupo)
