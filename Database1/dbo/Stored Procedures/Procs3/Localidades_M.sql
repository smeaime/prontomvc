CREATE  Procedure [dbo].[Localidades_M]

@IdLocalidad int ,
@Nombre varchar(50),
@CodigoPostal varchar(20),
@IdProvincia int,
@EnviarEmail tinyint,
@CodigoONCAA varchar(20),
@CodigoESRI varchar(2),
@CodigoWilliams varchar(20),
@CodigoLosGrobo varchar(20),
@Codigo int

AS

UPDATE Localidades
SET
 Nombre=@Nombre,
 CodigoPostal=@CodigoPostal,
 IdProvincia=@IdProvincia,
 EnviarEmail=@EnviarEmail,
 CodigoONCAA=@CodigoONCAA,
 CodigoESRI=@CodigoESRI,
 CodigoWilliams=@CodigoWilliams,
 CodigoLosGrobo=@CodigoLosGrobo,
 Codigo=@Codigo
WHERE (IdLocalidad=@IdLocalidad)

RETURN(@IdLocalidad)