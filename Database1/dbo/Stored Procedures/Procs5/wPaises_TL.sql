
CREATE Procedure [dbo].[wPaises_TL]
AS 
SELECT IdPais, Descripcion as [Titulo]
FROM Paises
ORDER BY Descripcion

