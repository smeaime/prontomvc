
CREATE Procedure [dbo].[Conceptos_TL]

AS 

SELECT IdConcepto, Descripcion as [Titulo]
FROM Conceptos 
WHERE IsNull(Grupo,0)=0
ORDER BY Descripcion
