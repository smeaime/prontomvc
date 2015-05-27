CREATE Procedure [dbo].[CurvasTalles_T]

@IdCurvaTalle int

AS 

SELECT*
FROM CurvasTalles
WHERE (IdCurvaTalle=@IdCurvaTalle)