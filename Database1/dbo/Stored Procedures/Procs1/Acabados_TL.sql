CREATE Procedure [dbo].[Acabados_TL]

AS 

SELECT 
 IdAcabado,
 Descripcion as [Titulo]
FROM Acabados
ORDER BY Descripcion