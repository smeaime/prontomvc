



















CREATE Procedure [dbo].[DetNotasCreditoOC_A]
@IdDetalleNotaCreditoOrdenesCompra int  output,
@IdNotaCredito int,
@IdDetalleOrdenCompra int,
@Cantidad numeric(18,2),
@PorcentajeCertificacion numeric(12,6)
As 
Insert into [DetalleNotasCreditoOrdenesCompra]
(
 IdNotaCredito,
 IdDetalleOrdenCompra,
 Cantidad,
 PorcentajeCertificacion
)
Values
(
 @IdNotaCredito,
 @IdDetalleOrdenCompra,
 @Cantidad,
 @PorcentajeCertificacion
)
Select @IdDetalleNotaCreditoOrdenesCompra=@@identity
Return(@IdDetalleNotaCreditoOrdenesCompra)



















