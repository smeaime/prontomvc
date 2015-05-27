CREATE Procedure [dbo].[Subrubros_A]

@IdSubrubro int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@EnviarEmail tinyint,
@Codigo int

AS 

INSERT INTO [Subrubros]
(
 Descripcion,
 Abreviatura,
 EnviarEmail,
 Codigo
)
VALUES
(
 @Descripcion,
 @Abreviatura,
 @EnviarEmail,
 @Codigo
)

SELECT @IdSubrubro=@@identity

RETURN(@IdSubrubro)
