
CREATE Procedure [dbo].[DetAutorizacionesCompra_M]

@IdDetalleAutorizacionCompra int,
@IdAutorizacionCompra int,
@IdArticulo int,
@Cantidad numeric(18,2),
@IdUnidad int,
@Observaciones ntext

AS

UPDATE [DetalleAutorizacionesCompra]
SET 
 IdAutorizacionCompra=@IdAutorizacionCompra,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 Observaciones=@Observaciones
WHERE (IdDetalleAutorizacionCompra=@IdDetalleAutorizacionCompra)

RETURN(@IdDetalleAutorizacionCompra)
