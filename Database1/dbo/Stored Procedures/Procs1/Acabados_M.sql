CREATE  Procedure [dbo].[Acabados_M]

@IdAcabado int ,
@Descripcion varchar(50),
@Abreviatura varchar(15)

AS

UPDATE Acabados
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura
WHERE (IdAcabado=@IdAcabado)

RETURN(@IdAcabado)