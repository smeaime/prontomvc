





























CREATE Procedure [dbo].[Calidades_T]
@IdCalidad int
AS 
SELECT IdCalidad, Descripcion
FROM Calidades
where (IdCalidad=@IdCalidad)






























