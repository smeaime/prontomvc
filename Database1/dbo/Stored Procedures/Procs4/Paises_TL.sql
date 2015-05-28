CREATE Procedure [dbo].[Paises_TL]

AS 

SELECT IdPais, Descripcion as [Titulo]
FROM Paises
ORDER BY Descripcion