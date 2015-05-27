




CREATE Procedure [dbo].[Sectores_T]
@IdSector int
AS 
SELECT *
FROM Sectores
WHERE (IdSector=@IdSector)




