
CREATE Procedure [dbo].[Choferes_T]

@IdChofer int

AS 

SELECT*
FROM Choferes
WHERE (IdChofer=@IdChofer)
