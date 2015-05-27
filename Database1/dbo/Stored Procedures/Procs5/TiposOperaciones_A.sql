
CREATE Procedure [dbo].[TiposOperaciones_A]

@IdTipoOperacion int  output,
@Codigo int,
@Descripcion varchar(50),
@IdTipoOperacionGrupo int

AS 

INSERT INTO [TiposOperaciones]
(
 Codigo,
 Descripcion,
 IdTipoOperacionGrupo
)
VALUES
(
 @Codigo,
 @Descripcion,
 @IdTipoOperacionGrupo
)
SELECT @IdTipoOperacion=@@identity

RETURN(@IdTipoOperacion)
