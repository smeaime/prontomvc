CREATE Procedure [dbo].[Marcas_TL]

AS 

SELECT IdMarca,Descripcion as [Titulo]
FROM Marcas
ORDER BY Descripcion