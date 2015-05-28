CREATE Procedure [dbo].[TiposRosca_A]

@IdTipoRosca int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@IdArticuloPRONTO_MANTENIMIENTO int

AS

INSERT INTO [TiposRosca]
(
 Descripcion,
 Abreviatura,
 IdArticuloPRONTO_MANTENIMIENTO
)
VALUES
(
 @Descripcion,
 @Abreviatura,
 @IdArticuloPRONTO_MANTENIMIENTO
)

SELECT @IdTipoRosca=@@identity

RETURN(@IdTipoRosca)