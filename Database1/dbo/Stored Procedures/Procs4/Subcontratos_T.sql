
CREATE Procedure [dbo].[Subcontratos_T]

@IdSubcontrato int

AS 

SELECT*
FROM Subcontratos
WHERE (IdSubcontrato=@IdSubcontrato)
