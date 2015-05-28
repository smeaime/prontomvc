





























CREATE Procedure [dbo].[Familias_T]
@IdFamilia smallint
AS 
SELECT*
FROM Familias
where (IdFamilia=@IdFamilia)






























