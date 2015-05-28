CREATE Procedure [dbo].[DetFacturasRemitos_A]

@IdDetalleFacturaRemitos int  output,
@IdDetalleFactura int,
@IdFactura int,
@IdDetalleRemito int,
@EnviarEmail int

As 

Insert into [DetalleFacturasRemitos]
(
 IdDetalleFactura,
 IdFactura,
 IdDetalleRemito,
 EnviarEmail
)
Values
(
 @IdDetalleFactura,
 @IdFactura,
 @IdDetalleRemito,
 @EnviarEmail
)

Select @IdDetalleFacturaRemitos=@@identity

Return(@IdDetalleFacturaRemitos)