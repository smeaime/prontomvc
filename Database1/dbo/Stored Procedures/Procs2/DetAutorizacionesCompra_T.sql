
CREATE Procedure [dbo].[DetAutorizacionesCompra_T]

@IdDetalleAutorizacionCompra int

AS 

SELECT *
FROM [DetalleAutorizacionesCompra]
WHERE (IdDetalleAutorizacionCompra=@IdDetalleAutorizacionCompra)
