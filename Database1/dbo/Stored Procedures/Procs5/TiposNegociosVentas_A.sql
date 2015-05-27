CREATE Procedure [dbo].[TiposNegociosVentas_A]

@IdTipoNegocioVentas int  output,
@Descripcion varchar(100),
@Codigo int,
@Grupo varchar(20)

AS

INSERT INTO [TiposNegociosVentas]
(
 Descripcion,
 Codigo,
 Grupo
)
VALUES
(
 @Descripcion,
 @Codigo,
 @Grupo
)

SELECT @IdTipoNegocioVentas=@@identity

RETURN(@IdTipoNegocioVentas)