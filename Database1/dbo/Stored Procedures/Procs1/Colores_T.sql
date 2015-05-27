CREATE Procedure [dbo].[Colores_T]

@IdColor int

AS 

SELECT*
FROM Colores
WHERE (IdColor=@IdColor)