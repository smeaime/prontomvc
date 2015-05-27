CREATE  Procedure [dbo].[TiposRosca_M]

@IdTipoRosca int ,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@IdArticuloPRONTO_MANTENIMIENTO int

AS

UPDATE TiposRosca
SET 
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 IdArticuloPRONTO_MANTENIMIENTO=@IdArticuloPRONTO_MANTENIMIENTO
WHERE (IdTipoRosca=@IdTipoRosca)

RETURN(@IdTipoRosca)