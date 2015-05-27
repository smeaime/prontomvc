CREATE Procedure [dbo].[Regiones_T]

@IdRegion int

AS 

SELECT *
FROM Regiones
WHERE (IdRegion=@IdRegion)