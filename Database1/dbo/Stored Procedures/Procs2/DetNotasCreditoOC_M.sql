



















CREATE Procedure [dbo].[DetNotasCreditoOC_M]
@IdDetalleNotaCreditoOrdenesCompra int,
@IdNotaCredito int,
@IdDetalleOrdenCompra int,
@Cantidad numeric(18,2),
@PorcentajeCertificacion numeric(12,6)
As
Update DetalleNotasCreditoOrdenesCompra
Set 
 IdNotaCredito=@IdNotaCredito,
 IdDetalleOrdenCompra=@IdDetalleOrdenCompra,
 Cantidad=@Cantidad,
 PorcentajeCertificacion=@PorcentajeCertificacion
Where (IdDetalleNotaCreditoOrdenesCompra=@IdDetalleNotaCreditoOrdenesCompra)
Return(@IdDetalleNotaCreditoOrdenesCompra)



















