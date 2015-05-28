





























CREATE Procedure [dbo].[Densidades_T]
@IdDensidad int
AS 
SELECT*
FROM Densidades
where (IdDensidad=@IdDensidad)






























