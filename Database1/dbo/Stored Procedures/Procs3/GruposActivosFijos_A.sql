
CREATE Procedure [dbo].[GruposActivosFijos_A]

@IdGrupoActivoFijo int  output,
@Descripcion varchar(50),
@Clase varchar(1)

AS

INSERT INTO [GruposActivosFijos]
(
 Descripcion,
 Clase
)
VALUES
(
 @Descripcion,
 @Clase
)

SELECT @IdGrupoActivoFijo=@@identity
RETURN(@IdGrupoActivoFijo)
