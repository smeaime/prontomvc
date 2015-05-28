CREATE  Procedure [dbo].[Feriados_M]

@IdFeriado int ,
@Descripcion varchar(50),
@Fecha datetime

AS

UPDATE Feriados
SET
 Descripcion=@Descripcion,
 Fecha=@Fecha
WHERE (IdFeriado=@IdFeriado)

RETURN(@IdFeriado)