












CREATE Procedure [dbo].[Provincias_T]
@IdProvincia tinyint 
AS 
SELECT *
FROM Provincias
WHERE (IdProvincia=@IdProvincia)












