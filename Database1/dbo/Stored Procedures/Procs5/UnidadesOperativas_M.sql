
CREATE  Procedure [dbo].[UnidadesOperativas_M]

@IdUnidadOperativa int ,
@Descripcion varchar(50),
@EnviarEmail tinyint,
@Codigo varchar(10)

AS

UPDATE UnidadesOperativas
SET 
 Descripcion=@Descripcion,
 EnviarEmail=@EnviarEmail,
 Codigo=@Codigo
WHERE (IdUnidadOperativa=@IdUnidadOperativa)

RETURN(@IdUnidadOperativa)
