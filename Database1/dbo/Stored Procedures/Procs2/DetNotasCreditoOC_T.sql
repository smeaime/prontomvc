



















CREATE Procedure [dbo].[DetNotasCreditoOC_T]
@IdDetalleNotaCreditoOrdenesCompra int
AS 
SELECT *
FROM DetalleNotasCreditoOrdenesCompra
WHERE (IdDetalleNotaCreditoOrdenesCompra=@IdDetalleNotaCreditoOrdenesCompra)




















