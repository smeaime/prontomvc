
CREATE Procedure [dbo].[Clausulas_TX_PorId]

@IdClausula int

AS 

SELECT*
FROM Clausulas
WHERE (IdClausula=@IdClausula)
