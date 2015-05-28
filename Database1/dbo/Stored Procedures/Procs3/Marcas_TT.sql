CREATE Procedure [dbo].[Marcas_TT]

AS 

SELECT 
 IdMarca,
 Codigo,
 Descripcion
FROM Marcas
ORDER BY Descripcion