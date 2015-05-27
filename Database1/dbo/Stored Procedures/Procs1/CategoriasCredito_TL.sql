CREATE Procedure [dbo].[CategoriasCredito_TL]

AS 

SELECT 
 IdCategoriaCredito,
 Convert(varchar,Importe)+IsNull(' - '+Descripcion,'') as [Titulo]
FROM CategoriasCredito
ORDER BY Importe, Descripcion