CREATE  Procedure [dbo].[TiposNegociosVentas_M]

@IdTipoNegocioVentas int ,
@Descripcion varchar(100),
@Codigo int,
@Grupo varchar(20)

AS

UPDATE TiposNegociosVentas
SET 
 Descripcion=@Descripcion,
 Codigo=@Codigo,
 Grupo=@Grupo
WHERE (IdTipoNegocioVentas=@IdTipoNegocioVentas)

RETURN(@IdTipoNegocioVentas)