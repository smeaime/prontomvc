
CREATE Procedure [dbo].[Codigos_TL]

AS 

SELECT IdCodigo, Descripcion as [Titulo]
FROM Codigos 
ORDER BY Descripcion
