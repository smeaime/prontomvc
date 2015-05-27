CREATE Procedure [dbo].[Feriados_A]

@IdFeriado int  output,
@Descripcion varchar(50),
@Fecha datetime

AS 

INSERT INTO [Feriados]
(
 Descripcion,
 Fecha
)
VALUES
(
 @Descripcion,
 @Fecha
)

SELECT @IdFeriado=@@identity

RETURN(@IdFeriado)