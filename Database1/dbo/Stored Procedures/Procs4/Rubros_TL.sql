CREATE Procedure [dbo].[Rubros_TL]

AS 

SELECT IdRubro,Descripcion as Titulo
FROM Rubros 
ORDER BY Descripcion