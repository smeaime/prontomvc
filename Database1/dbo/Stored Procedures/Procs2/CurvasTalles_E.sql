CREATE Procedure [dbo].[CurvasTalles_E]

@IdCurvaTalle int  

AS 

DELETE CurvasTalles
WHERE (IdCurvaTalle=@IdCurvaTalle)