CREATE Procedure [dbo].[Calles_TL]

AS 

SELECT IdCalle,Nombre as [Titulo]
FROM Calles
ORDER BY Nombre