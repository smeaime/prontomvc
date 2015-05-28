
CREATE Procedure [dbo].[wSubrubros_E]

@IdSubrubro int  

AS 

DELETE Subrubros
WHERE (IdSubrubro=@IdSubrubro)

