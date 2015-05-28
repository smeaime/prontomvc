CREATE Procedure [dbo].[Calles_TT]

AS 

SELECT 
 IdCalle,
 Nombre as [Calle]
FROM Calles
ORDER BY Nombre