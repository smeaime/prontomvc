CREATE Procedure [dbo].[CurvasTalles_TL]

AS 

SELECT 
 IdCurvaTalle,
 Descripcion as [Titulo]
FROM CurvasTalles 
ORDER BY Descripcion