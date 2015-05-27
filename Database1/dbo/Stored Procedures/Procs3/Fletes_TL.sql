
CREATE Procedure [dbo].[Fletes_TL]

AS 

SELECT IdFlete, Descripcion as [Titulo]
FROM Fletes 
ORDER BY Descripcion
