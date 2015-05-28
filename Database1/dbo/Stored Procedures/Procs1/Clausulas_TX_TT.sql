
CREATE Procedure [dbo].[Clausulas_TX_TT]

@IdClausula int

AS 

SELECT *
FROM Clausulas
WHERE (IdClausula=@IdClausula)
