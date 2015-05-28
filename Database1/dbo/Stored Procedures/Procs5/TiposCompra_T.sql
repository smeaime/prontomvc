CREATE Procedure [dbo].[TiposCompra_T]

@IdTipoCompra int

AS 

SELECT*
FROM TiposCompra
WHERE (IdTipoCompra=@IdTipoCompra)