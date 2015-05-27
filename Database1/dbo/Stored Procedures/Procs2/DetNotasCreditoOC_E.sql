



















CREATE Procedure [dbo].[DetNotasCreditoOC_E]
@IdDetalleNotaCreditoOrdenesCompra int
AS 
Delete DetalleNotasCreditoOrdenesCompra
Where (IdDetalleNotaCreditoOrdenesCompra=@IdDetalleNotaCreditoOrdenesCompra)




















