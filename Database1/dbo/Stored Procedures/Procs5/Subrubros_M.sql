CREATE  Procedure [dbo].[Subrubros_M]

@IdSubrubro int ,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@EnviarEmail tinyint,
@Codigo int

AS

UPDATE Subrubros
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 EnviarEmail=@EnviarEmail,
 Codigo=@Codigo
WHERE (IdSubrubro=@IdSubrubro)

RETURN(@IdSubrubro)
