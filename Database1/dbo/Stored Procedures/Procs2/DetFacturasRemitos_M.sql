


CREATE Procedure [dbo].[DetFacturasRemitos_M]
@IdDetalleFacturaRemitos int,
@IdDetalleFactura int,
@IdFactura int,
@IdDetalleRemito int,
@EnviarEmail int
As
Update DetalleFacturasRemitos
Set 
 IdDetalleFactura=@IdDetalleFactura,
 IdFactura=@IdFactura,
 IdDetalleRemito=@IdDetalleRemito,
 EnviarEmail=@EnviarEmail
Where (IdDetalleFacturaRemitos=@IdDetalleFacturaRemitos)
Return(@IdDetalleFacturaRemitos)


