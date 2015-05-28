CREATE  Procedure [dbo].[Paises_M]

@IdPais int ,
@Descripcion varchar(50),
@Codigo varchar(3),
@EnviarEmail tinyint,
@Codigo2 varchar(10),
@Cuit varchar(11),
@CodigoESRI varchar(2)

AS

UPDATE Paises
SET
 Descripcion=@Descripcion,
 Codigo=@Codigo,
 EnviarEmail=@EnviarEmail,
 Codigo2=@Codigo2,
 Cuit=@Cuit,
 CodigoESRI=@CodigoESRI
WHERE (IdPais=@IdPais)

RETURN(@IdPais)