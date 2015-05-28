
CREATE Procedure [dbo].[Conjuntos_T]

@IdConjunto int

AS 

SELECT * 
FROM Conjuntos
WHERE (IdConjunto=@IdConjunto)
