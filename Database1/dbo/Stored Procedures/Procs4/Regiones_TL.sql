CREATE Procedure [dbo].[Regiones_TL]

AS 

SELECT 
 IdRegion,
 Descripcion as [Titulo]
FROM Regiones
ORDER BY Descripcion