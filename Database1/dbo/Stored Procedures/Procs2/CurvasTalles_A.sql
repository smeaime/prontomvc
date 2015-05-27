CREATE Procedure [dbo].[CurvasTalles_A]

@IdCurvaTalle int output,
@Codigo int,
@Descripcion varchar(50),
@Curva varchar(50),
@CurvaCodigos varchar(50),
@MostrarCurvaEnInformes varchar(2)

AS 

INSERT INTO [CurvasTalles]
(
 Codigo,
 Descripcion,
 Curva,
 CurvaCodigos,
 MostrarCurvaEnInformes
)
VALUES
(
 @Codigo,
 @Descripcion,
 @Curva,
 @CurvaCodigos,
 @MostrarCurvaEnInformes
)

SELECT @IdCurvaTalle=@@identity

RETURN(@IdCurvaTalle)