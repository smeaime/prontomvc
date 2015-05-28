



CREATE Procedure [dbo].[DetNotasCreditoProvincias_A]
@IdDetalleNotaCreditoProvincias int output,
@IdNotaCredito int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
As 
Insert into [DetalleNotasCreditoProvincias]
(
 IdNotaCredito,
 IdProvinciaDestino,
 Porcentaje
)
Values
(
 @IdNotaCredito,
 @IdProvinciaDestino,
 @Porcentaje
)
Select @IdDetalleNotaCreditoProvincias=@@identity
Return(@IdDetalleNotaCreditoProvincias)




