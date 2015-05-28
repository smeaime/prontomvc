






























CREATE Procedure [dbo].[DetFacturasOrdenesCompra_T]
@IdDetalleFacturaOrdenesCompra int
AS 
SELECT *
FROM DetalleFacturasOrdenesCompra
WHERE (IdDetalleFacturaOrdenesCompra=@IdDetalleFacturaOrdenesCompra)































