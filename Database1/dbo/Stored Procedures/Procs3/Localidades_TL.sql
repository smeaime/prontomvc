
CREATE Procedure [dbo].[Localidades_TL]
AS 
SELECT IdLocalidad, Nombre as [Titulo]
FROM Localidades 
ORDER BY Nombre
