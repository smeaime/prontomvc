
CREATE Procedure [dbo].[GruposObras_A]

@IdGrupoObra int  output,
@Descripcion varchar(50)

AS 

INSERT INTO [GruposObras]
(
 Descripcion
)
Values
(
 @Descripcion
)

SELECT @IdGrupoObra=@@identity
RETURN(@IdGrupoObra)
