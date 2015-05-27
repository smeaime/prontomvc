CREATE Procedure [dbo].[Paises_A]

@IdPais int  output,
@Descripcion varchar(50),
@Codigo varchar(3),
@EnviarEmail tinyint,
@Codigo2 varchar(10),
@Cuit varchar(11),
@CodigoESRI varchar(2)

AS 

INSERT INTO Paises
(
 Descripcion,
 Codigo,
 EnviarEmail,
 Codigo2,
 Cuit,
 CodigoESRI
)
VALUES
(
 @Descripcion,
 @Codigo,
 @EnviarEmail,
 @Codigo2,
 @Cuit,
 @CodigoESRI
)

SELECT @IdPais=@@identity

RETURN(@IdPais)