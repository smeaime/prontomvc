
CREATE Procedure [dbo].[wRubros_E]

@IdRubro int  

AS 

DELETE Rubros
WHERE (IdRubro=@IdRubro)

