


CREATE Procedure [dbo].[DetFacturasProvincias_A]
@IdDetalleFacturaProvincias int output,
@IdFactura int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2),
@EnviarEmail int = null
As 
Insert into [DetalleFacturasProvincias]
(
 IdFactura,
 IdProvinciaDestino,
 Porcentaje,
 EnviarEmail
)
Values
(
 @IdFactura,
 @IdProvinciaDestino,
 @Porcentaje,
 @EnviarEmail
)
Select @IdDetalleFacturaProvincias=@@identity
Return(@IdDetalleFacturaProvincias)


