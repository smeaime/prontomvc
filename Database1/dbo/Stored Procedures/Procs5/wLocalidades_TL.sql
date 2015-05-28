
CREATE Procedure [dbo].[wLocalidades_TL]
AS 
SELECT IdLocalidad, Nombre as [Titulo]
FROM Localidades 
ORDER BY Nombre

