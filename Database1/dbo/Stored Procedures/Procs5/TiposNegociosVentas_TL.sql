CREATE Procedure [dbo].[TiposNegociosVentas_TL]

AS 

SELECT 
 IdTipoNegocioVentas,
 Descripcion as [Titulo]
FROM TiposNegociosVentas 
ORDER by Descripcion