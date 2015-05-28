
CREATE Procedure [dbo].[TiposOperacionesGrupos_A]

@IdTipoOperacionGrupo int  output,
@Descripcion varchar(50)

AS 

INSERT INTO [TiposOperacionesGrupos]
(
 Descripcion
)
VALUES
(
 @Descripcion
)
SELECT @IdTipoOperacionGrupo=@@identity

RETURN(@IdTipoOperacionGrupo)
