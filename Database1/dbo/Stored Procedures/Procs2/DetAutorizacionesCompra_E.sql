
CREATE Procedure [dbo].[DetAutorizacionesCompra_E]

@IdDetalleAutorizacionCompra int  

AS 

DELETE [DetalleAutorizacionesCompra]
WHERE (IdDetalleAutorizacionCompra=@IdDetalleAutorizacionCompra)
