CREATE Procedure [dbo].[Calles_T]

@IdCalle int

AS 

SELECT *
FROM Calles
WHERE (IdCalle=@IdCalle)