


CREATE Procedure [dbo].[DetFacturasOrdenesCompra_M]
@IdDetalleFacturaOrdenesCompra int,
@IdDetalleFactura int,
@IdFactura int,
@IdDetalleOrdenCompra int,
@EnviarEmail int
As
Update DetalleFacturasOrdenesCompra
Set 
 IdDetalleFactura=@IdDetalleFactura,
 IdFactura=@IdFactura,
 IdDetalleOrdenCompra=@IdDetalleOrdenCompra,
 EnviarEmail=@EnviarEmail
Where (IdDetalleFacturaOrdenesCompra=@IdDetalleFacturaOrdenesCompra)
Return(@IdDetalleFacturaOrdenesCompra)


