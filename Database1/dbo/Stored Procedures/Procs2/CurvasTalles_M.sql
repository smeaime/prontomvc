CREATE  Procedure [dbo].[CurvasTalles_M]

@IdCurvaTalle int ,
@Codigo int,
@Descripcion varchar(50),
@Curva varchar(50),
@CurvaCodigos varchar(50),
@MostrarCurvaEnInformes varchar(2)

AS

UPDATE CurvasTalles
SET
 Codigo=@Codigo,
 Descripcion=@Descripcion,
 Curva=@Curva,
 CurvaCodigos=@CurvaCodigos,
 MostrarCurvaEnInformes=@MostrarCurvaEnInformes
WHERE (IdCurvaTalle=@IdCurvaTalle)

RETURN(@IdCurvaTalle)