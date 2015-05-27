


CREATE Procedure [dbo].[DetFacturasOrdenesCompra_A]
@IdDetalleFacturaOrdenesCompra int  output,
@IdDetalleFactura int,
@IdFactura int,
@IdDetalleOrdenCompra int,
@EnviarEmail int
As 
Insert into [DetalleFacturasOrdenesCompra]
(
 IdDetalleFactura,
 IdFactura,
 IdDetalleOrdenCompra,
 EnviarEmail
)
Values
(
 @IdDetalleFactura,
 @IdFactura,
 @IdDetalleOrdenCompra,
 @EnviarEmail
)
Select @IdDetalleFacturaOrdenesCompra=@@identity
Return(@IdDetalleFacturaOrdenesCompra)


