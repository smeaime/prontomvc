CREATE Procedure [dbo].[Colores_TL]

AS 

SELECT 
 IdColor,
 Descripcion as [Titulo]
FROM Colores 
ORDER BY Descripcion