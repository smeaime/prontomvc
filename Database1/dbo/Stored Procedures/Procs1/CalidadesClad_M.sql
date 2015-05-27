
CREATE  Procedure [dbo].[CalidadesClad_M]

@IdCalidadClad int ,
@Descripcion varchar(50),
@Abreviatura varchar(100)

AS

UPDATE CalidadesClad
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura
WHERE (IdCalidadClad=@IdCalidadClad)

RETURN(@IdCalidadClad)
