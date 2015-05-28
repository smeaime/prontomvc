
CREATE Procedure [dbo].[Clausulas_T]

@IdClausula int

AS 

SELECT*
FROM Clausulas
WHERE (IdClausula=@IdClausula)
