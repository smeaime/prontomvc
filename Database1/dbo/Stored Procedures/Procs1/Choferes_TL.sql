
CREATE Procedure [dbo].[Choferes_TL]

AS 

SELECT IdChofer, Nombre as [Titulo]
FROM Choferes 
ORDER BY Nombre
