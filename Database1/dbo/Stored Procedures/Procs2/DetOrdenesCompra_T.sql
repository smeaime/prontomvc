




























CREATE Procedure [dbo].[DetOrdenesCompra_T]
@IdDetalleOrdenCompra int
AS 
SELECT *
FROM DetalleOrdenesCompra
WHERE (IdDetalleOrdenCompra=@IdDetalleOrdenCompra)





























