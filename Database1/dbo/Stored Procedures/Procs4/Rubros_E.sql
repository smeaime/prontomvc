CREATE Procedure [dbo].[Rubros_E]

@IdRubro int 

AS 

DELETE Rubros
WHERE (IdRubro=@IdRubro)