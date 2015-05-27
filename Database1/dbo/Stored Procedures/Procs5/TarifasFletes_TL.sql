CREATE Procedure [dbo].[TarifasFletes_TL]

AS 

SELECT 
 IdTarifaFlete,
 Codigo COLLATE Modern_Spanish_CI_AS +' - '+Descripcion+' [ '+Convert(varchar,ValorUnitario) +' ]' as [Titulo]
FROM TarifasFletes
ORDER BY Descripcion