
CREATE  Procedure [dbo].[Tipos_M]

@IdTipo int ,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@Codigo int,
@Grupo int

AS

UPDATE Tipos
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 Codigo=@Codigo,
 Grupo=@Grupo
WHERE (IdTipo=@IdTipo)

RETURN(@IdTipo)
