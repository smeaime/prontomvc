
CREATE Procedure [dbo].[Fletes_T]

@IdFlete int

AS 

SELECT*
FROM Fletes
WHERE (IdFlete=@IdFlete)
