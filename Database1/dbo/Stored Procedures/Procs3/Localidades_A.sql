CREATE Procedure [dbo].[Localidades_A]

@IdLocalidad int  output,
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

INSERT INTO [Localidades]
(
 Nombre,
 CodigoPostal,
 IdProvincia,
 EnviarEmail,
 CodigoONCAA,
 CodigoESRI,
 CodigoWilliams,
 CodigoLosGrobo,
 Codigo
)
VALUES
(
 @Nombre,
 @CodigoPostal,
 @IdProvincia,
 @EnviarEmail,
 @CodigoONCAA,
 @CodigoESRI,
 @CodigoWilliams,
 @CodigoLosGrobo,
 @Codigo
)

SELECT @IdLocalidad=@@identity

RETURN(@IdLocalidad)