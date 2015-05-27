CREATE Procedure [dbo].[TiposCompra_TL]

AS 

SELECT 
 IdTipoCompra,
 Descripcion as [Titulo]
FROM TiposCompra 
ORDER by Descripcion