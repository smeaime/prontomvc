
CREATE Procedure [dbo].[CalidadesClad_A]

@IdCalidadClad int  output,
@Descripcion varchar(50),
@Abreviatura varchar(100)

AS 

INSERT INTO [CalidadesClad]
(
 Descripcion, 
 Abreviatura
)
VALUES
(
 @Descripcion, 
 @Abreviatura
)

SELECT @IdCalidadClad=@@identity
RETURN(@IdCalidadClad)
