CREATE Procedure [dbo].[TiposCompra_E]

@IdTipoCompra int  

AS 

DELETE TiposCompra
WHERE (IdTipoCompra=@IdTipoCompra)