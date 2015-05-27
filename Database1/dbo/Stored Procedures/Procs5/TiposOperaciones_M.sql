


CREATE  Procedure [dbo].[TiposOperaciones_M]

@IdTipoOperacion int ,
@Codigo int,
@Descripcion varchar(50),
@IdTipoOperacionGrupo int

AS

UPDATE TiposOperaciones
SET
 Codigo=@Codigo,
 Descripcion=@Descripcion,
 IdTipoOperacionGrupo=@IdTipoOperacionGrupo
WHERE (IdTipoOperacion=@IdTipoOperacion)

RETURN(@IdTipoOperacion)
