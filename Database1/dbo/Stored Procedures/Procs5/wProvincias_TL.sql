
CREATE Procedure [dbo].[wProvincias_TL]
AS 
SELECT IdProvincia, Nombre as [Titulo]
FROM Provincias 
ORDER BY Nombre

