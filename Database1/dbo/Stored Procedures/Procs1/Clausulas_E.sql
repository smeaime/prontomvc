
CREATE Procedure [dbo].[Clausulas_E]

@IdClausula int  

AS 

DELETE Clausulas
WHERE (IdClausula=@IdClausula)
